import 'package:letstalk/models/user.dart';

class Server{

  static User? _user;
  static User? get currentUser => _user;
  
  static Future<User?> signUpWithUsernameAndPassword(String username, String password) async{
    //TODO
    await Future.delayed(const Duration(seconds: 1));
    _user = User(username);
    return _user;
  }

  static Future<User?> loginWithUsernameAndPassword(String username, String password) async{
    //TODO
    await Future.delayed(const Duration(seconds: 1));
    return _user;
  }

  static Future<User?> loginWithToken(String token) async{
    //TODO
    await Future.delayed(const Duration(seconds: 1));
    return _user;
  }

  static Future<bool> changeUsername(String newUsername) async{
    if(_user != null){
      //TODO
      _user = User(newUsername);
      return true;
    }
    return false;
  }

  static Future<bool> changeProfileImage() async{
    if(_user != null){
      //TODO
      return true;
    }
    return false;
  }

}