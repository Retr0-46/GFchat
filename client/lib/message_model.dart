class Message {
  final String text;
  final String timestamp;

  Message({required this.text, required this.timestamp});

  // Метод для создания объекта Message из JSON
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      timestamp: json['timestamp'],
    );
  }

  // Метод для преобразования объекта Message в JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'timestamp': timestamp,
    };
  }
}
