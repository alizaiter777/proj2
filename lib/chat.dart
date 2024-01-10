import 'package:flutter/material.dart';
class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final List<String> chatMessages = [];
  final TextEditingController messageController = TextEditingController();

  void _sendMessage(String message) {
    setState(() {
      chatMessages.add('User: $message');

      // Simulating responses from the agent
      if (message.toLowerCase() == 'hello' ||
          message.toLowerCase() == 'hii' ||
          message.toLowerCase() == 'hi' ||
          message.toLowerCase() == 'helo') {
        chatMessages.add('Agent: Hello ');
        chatMessages.add('Agent: How can we help you?');
      } else if (message.toLowerCase() == 'still available' ||
          message.toLowerCase() == 'available ? ') {
        chatMessages.add('Agent: Yes');
      } else if (message.toLowerCase() == 'i need this house') {
        chatMessages.add(
          'Agent: Great! You have to come to the office to set up the required procedures.',
        );
      } else if (message.toLowerCase() == 'final price' ||
          message.toLowerCase() == 'price') {
        chatMessages.add(
          'Agent: The listed prices are limited according to a study.',
        );
      } else if (message.toLowerCase() == 'thank you' ||
          message.toLowerCase() == 'thankyou') {
        chatMessages.add(
          'Agent: If you have any other questions, feel free to ask.',
        );
      } else {
        chatMessages.add(
          'Agent: I\'m sorry, I didn\'t understand that. How can we assist you?',
        );
      }
    });

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat '),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  final message = chatMessages[index];
                  final isUserMessage = message.startsWith('User:');

                  return ListTile(
                    title: isUserMessage
                        ? RichText(
                      text: TextSpan(
                        text: 'User: ',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: message.substring('User: '.length),
                            style: DefaultTextStyle.of(context).style,
                          ),
                        ],
                      ),
                    )
                        : Text(message),
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
                      controller: messageController,
                      decoration: InputDecoration(hintText: 'Type a message...'),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      String message = messageController.text.trim();
                      if (message.isNotEmpty) {
                        _sendMessage(message);
                      }
                    },
                    child: Text('Send'),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
