import 'package:letstalk/models/enums/flag.dart';

class User{
  final String _id;
  final String? token;
  String username;
  String? urlImage;
  final List<Flag> _flags = [];

  User(this._id, this.username, {this.token});

  String get id => _id;

  List<Flag> get flags => List<Flag>.unmodifiable(_flags);
  addFlag(Flag flag){
    if(!_flags.contains(flag)){
      _flags.add(flag);
    }
  }
  bool removeFlag(Flag flag) => _flags.remove(flag);
}