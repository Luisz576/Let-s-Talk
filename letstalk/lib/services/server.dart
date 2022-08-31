import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letstalk/models/enums/flag.dart';
import 'package:letstalk/models/message.dart';
import 'package:letstalk/models/user.dart';

class Server{

  static User? _user;
  static User? get currentUser => _user;

  // The correct way is the application can't get direct all user information (like the token and generate that) but how it's only a simple test app to have fun with your friends don't worry about it
  
  static void logout(){
    _user = null;
  }

  static Future<User?> signUpWithUsernameAndPassword(String username, String password) async{
    if(_user != null){
      logout();
    }
    // this code is unsecure, is recommeded you change it
    if(await _getUserByUsername(username) == null){
      String token = '${DateTime.now().toString()}-$username';
      final ref = FirebaseDatabase.instance.ref('users').push();
      ref.child("username").set(username);
      ref.child("password").set(md5.convert(utf8.encode(password)).toString());
      ref.child("imageUrl").set("");
      ref.child("token").set(token);
      ref.child("id").set(ref.key);
      _user = User(token, username);
    }
    return _user;
  }

  static Future<User?> loginWithUsernameAndPassword(String username, String password) async{
    // this code is unsecure, is recommeded you change it
    final users = (await FirebaseDatabase.instance.ref("users").get()).children;
    for(DataSnapshot snapshot in users){
      final data = await FirebaseDatabase.instance.ref("users/${snapshot.key}").get();
      if(data.child("username").value.toString() == username){
        if(data.child("password").value.toString() == md5.convert(utf8.encode(password)).toString()){
          String token = '${DateTime.now().toString()}-$username';
          final ref = FirebaseDatabase.instance.ref('users/${data.key}');
          ref.child("token").set(token);
          _user = User(data.child("id").value.toString(), data.child("username").value.toString(), token: token);
          _user!.urlImage = data.child("imageUrl").value != null ? data.child("imageUrl").value!.toString() : null;
          if(data.child("flags").value != null){
            for(Object flag in data.child("flags").value! as List){
              _user!.addFlag(Flag.fromValue(flag.toString()));
            }
          }
        }
      }
    }
    return _user;
  }

  static Future<User?> loginWithToken(String token) async{
    // this code is unsecure, is recommeded you change it
    final users = (await FirebaseDatabase.instance.ref("users").get()).children;
    for(DataSnapshot snapshot in users){
      final data = await FirebaseDatabase.instance.ref("users/${snapshot.key}").get();
      if(data.child("token").value.toString() == token){
        _user = User(data.child("id").value.toString(), data.child("username").value.toString(), token: token);
        _user!.urlImage = data.child("imageUrl").value != null ? data.child("imageUrl").value!.toString() : null;
        if(data.child("flags").value != null){
          for(Object flag in data.child("flags").value! as List){
            _user!.addFlag(Flag.fromValue(flag.toString()));
          }
        }
      }
    }
    return _user;
  }

  static Future<bool> changeUsername(String newUsername) async{
    if(_user != null){
      if(await _getUserByUsername(newUsername) == null){
        // this code is unsecure, is recommeded you change it
        await FirebaseDatabase.instance.ref("users/${_user!.id}/username").set(newUsername);
        _user!.username = newUsername;
        return true;
      }
    }
    return false;
  }

  static Future<bool> changePassword(String currentPassword, String newPassword) async{
    if(_user != null){
      // this code is unsecure, is recommeded you change it
      final ref = await FirebaseDatabase.instance.ref("users/${_user!.id}/password").get();
      if(ref.value.toString() == md5.convert(utf8.encode(currentPassword)).toString()){
        await FirebaseDatabase.instance.ref("users/${_user!.id}/password").set(md5.convert(utf8.encode(newPassword)).toString());
        return true;
      }
    }
    return false;
  }

  static changeProfileImage(XFile xfile, {required Function() whenComplete, required Function() whenError}) async{
    if(_user != null){
      // this code is unsecure, is recommeded you change it
      final file = File(xfile.path);
      try{
        String ref = 'profile_images/${_user!.username}-${DateTime.now().toString()}.jpg';
        UploadTask uploadTask = FirebaseStorage.instance.ref(ref).putFile(file);
        uploadTask.whenComplete(() async{
          String imageUrl = await FirebaseStorage.instance.ref(ref).getDownloadURL();
          await _changeProfileImage(imageUrl);
          whenComplete();
        });
      } on FirebaseException catch(_){
        whenError();
      }
    }else{
      whenError();
    }
  }
  static Future<void> _changeProfileImage(String imageUrl) async{
    // this code is unsecure, is recommeded you change it
    await FirebaseDatabase.instance.ref('users/${_user!.id}/imageUrl').set(imageUrl);
    _user!.urlImage = imageUrl;
  }

  static Future<bool> sendMessage(String message) async{
    if(_user != null){
      // this code is unsecure, is recommeded you change it
      await FirebaseFirestore.instance.collection("messages").add({
        "createdAt": DateTime.now().toString(),
        "message": message,
        "owner": _user!.id,
        "deleted": false,
      });
      return true;
    }
    return false;
  }

  static Stream<List<Future<Message>>> getMessages(){
    final snapshotsDocs = FirebaseFirestore.instance.collection("messages").orderBy("createdAt", descending: true).snapshots().map((e) => e.docs);
    return snapshotsDocs.map((list){
      return list.map((document) async{
        return Message(
          id: document.id,
          owner: await _getUserById(document.data()["owner"]),
          message: document.data()["message"],
          imageUrl: document.data()["image"],
          deleted: document.data()["deleted"] ?? false,
        );
      }).toList();
    });
  }

  static Future<void> deleteMessage(String messageId) async{
    if(_user == null){ return; }
    // this code is unsecure, is recommeded you change it
    final data = await FirebaseFirestore.instance.collection("messages").doc(messageId).get();
    if(data["owner"] == _user!.id){
      await FirebaseFirestore.instance.collection("messages").doc(messageId).update(
        {
          "deleted": true
        }
      );
    }
  }

  static Future<bool> sendImage(XFile xfile, {required Function() whenComplete, required Function() whenError}) async{
    if(_user != null){
      // this code is unsecure, is recommeded you change it
      final file = File(xfile.path);
      try{
        String ref = 'images/img-${_user!.username}-${DateTime.now().toString()}.jpg';
        if(file.path.substring(file.path.length - 4, file.path.length) == "gif"){
          ref = 'images/img-${_user!.username}-${DateTime.now().toString()}.gif';
        }
        UploadTask uploadTask = FirebaseStorage.instance.ref(ref).putFile(file);
        uploadTask.whenComplete(() async{
          String imageUrl = await FirebaseStorage.instance.ref(ref).getDownloadURL();
          await FirebaseFirestore.instance.collection("messages").add({
            "createdAt": DateTime.now().toString(),
            "message": "<image> !sua versão ainda não suporta imagens",
            "owner": _user!.id,
            "deleted": false,
            "image": imageUrl
          });
          whenComplete();
          return true;
        });
      } on FirebaseException catch(_){
        whenError();
      }
    }else{
      whenError();
    }
    return false;
  }

  static Future<User?> _getUserById(String id) async{
    // this code is unsecure, is recommeded you change it
    final data = await FirebaseDatabase.instance.ref("users/$id").get();
    if(data.exists){
      User user = User(data.child("id").value.toString(), data.child("username").value.toString());
      user.urlImage = data.child("imageUrl").value != null ? data.child("imageUrl").value!.toString() : null;
      if(data.child("flags").value != null){
        for(Object flag in data.child("flags").value! as List){
          user.addFlag(Flag.fromValue(flag.toString()));
        }
      }
      return user;
    }
    return null;
  }

  static Future<User?> _getUserByUsername(String username) async{
    // this code is unsecure, is recommeded you change it
    final users = (await FirebaseDatabase.instance.ref("users").get()).children;
    for(DataSnapshot snapshot in users){
      final data = await FirebaseDatabase.instance.ref("users/${snapshot.key}").get();
      if(data.child("username").value.toString() == username){
        User user = User(data.child("id").value.toString(), data.child("username").value.toString());
        user.urlImage = data.child("imageUrl").value != null ? data.child("imageUrl").value!.toString() : null;
        if(data.child("flags").value != null){
          for(Object flag in data.child("flags").value! as List){
            user.addFlag(Flag.fromValue(flag.toString()));
          }
        }
        return user;
      }
    }
    return null;
  }

}