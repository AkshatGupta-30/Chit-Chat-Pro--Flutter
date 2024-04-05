import 'dart:io';

class Message {
  String role;
  String content;
  File? image;
  Message({required this.role, required this.content, this.image});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(role: json['role'], content: json['content']);
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'content': content,
    };
  }

  void addImage(File img) => image = img;
}