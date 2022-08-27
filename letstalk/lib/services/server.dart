import 'package:letstalk/models/user.dart';

class Server{

  static User? _user;
  static User? get user => _user;
  
  static Future<User?> signUpWithUsernameAndPassword(String username, String password) async{
    //TODO
    return _user;
  }

  static Future<User?> loginWithUsernameAndPassword(String username, String password) async{
    //TODO
    return _user;
  }

  static Future<User?> loginWithToken(String token) async{
    //TODO
    return _user;
  }

}