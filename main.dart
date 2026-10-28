import 'package:flutter/material.dart';

void main() {
  runApp(const MenimDostumApp());
}

class MenimDostumApp extends StatelessWidget {
  const MenimDostumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mənim Dostum',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {"sender": "bot", "message": "Salam dostum, necəsən? Nə edirsən? 😃"}
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    String userText = _controller.text;
    setState(() {
      _messages.add({"sender": "user", "message": userText});
      
      // Əhval analizi və cavab məntiqi
      String botReply = "Hər şey yaxşı olacaq, mən həmişə səninləyəm! 💪";
      String lower = userText.toLowerCase();
      
      if (lower.contains("pis") || lower.contains("darıxıram") || lower.contains("yorğun")) {
        botReply = "Üzülmə dostum, hər çətinliyin bir sonu var. Istəsən dərdini bölüşə bilərsən. 💙";
      } else if (lower.contains("yaxşı") || lower.contains("əla") || lower.contains("super")) {
        botReply = "Bunu eşitməyə çox sevindim! Belə davam et! 🚀";
      }

      _messages.add({"sender": "bot", "message": botReply});
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mənim Dostum - Sırdaş'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool isUser = _messages[index]["sender"] == "user";
                return Container(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.teal[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      _messages[index]["message"]!,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Əhvalını yaz...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.teal),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
