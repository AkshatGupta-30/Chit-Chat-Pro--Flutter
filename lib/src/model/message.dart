class Message {
  String role;
  String content;
  Message({required this.role, required this.content});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(role: json['role'], content: json['content']);
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'content': content,
    };
  }
}