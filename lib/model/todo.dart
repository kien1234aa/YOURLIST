class Todo {
  final int? id;
  late final String content;
  final String time;

  Todo({this.id, required this.content, required this.time});

  // Chuyển từ Map sang Todo
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      content: map['content'],
      time: map['time'], // Lưu trữ trực tiếp chuỗi time
    );
  }

  // Chuyển Todo sang Map để lưu vào DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'time': time, // Lưu trữ thời gian dưới dạng chuỗi
    };
  }
}
