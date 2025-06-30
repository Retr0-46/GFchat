// import 'package:flutter/material.dart';
// import 'api_service.dart';
// import 'message_model.dart';

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final ApiService _apiService = ApiService();
//   List<Message> _messages = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadMessages();
//   }

//   // Метод для загрузки сообщений
//   void _loadMessages() async {
//     List<Message>? messages = await _apiService.getMessages();
//     if (messages != null) {
//       setState(() {
//         _messages = messages;
//       });
//     }
//   }

//   // Метод для отправки сообщения
//   void _sendMessage() async {
//     if (_controller.text.isNotEmpty) {
//       Message? newMessage = await _apiService.sendMessage(_controller.text);
//       if (newMessage != null) {
//         setState(() {
//           _messages.add(newMessage);
//         });
//         _controller.clear();
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Чат')),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 return ListTile(
//                   title: Text(message.text),
//                   subtitle: Text(message.timestamp),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(hintText: 'Введите сообщение...'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
