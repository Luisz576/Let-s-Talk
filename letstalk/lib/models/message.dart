import 'package:letstalk/models/user.dart';

class Message{
  final User owner;
  final String message;

  Message({required this.owner, required this.message});
}