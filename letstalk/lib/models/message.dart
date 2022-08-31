import 'package:letstalk/models/user.dart';

class Message{
  final User? owner;
  final String id, message;
  final String? imageUrl;
  final bool deleted;

  Message({required this.deleted, required this.id, required this.owner, required this.message, required this.imageUrl});
}