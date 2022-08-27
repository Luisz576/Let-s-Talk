import 'package:letstalk/models/enums/flag.dart';

class User{
  String username;
  String? urlImage, token;
  final List<Flag> _flags = [];

  User(this.username);

  List<Flag> get flags => List<Flag>.unmodifiable(_flags);
  set addFlag(Flag flag){
    if(!_flags.contains(flag)){
      _flags.add(flag);
    }
  }
  bool removeFlag(Flag flag) => _flags.remove(flag);
}