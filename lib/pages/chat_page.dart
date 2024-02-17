import 'package:firebase_chat/config/import.dart';
import 'package:firebase_chat/stores/chat_controller.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key, required this.reciverUserID, required this.reciverUserEmail});
  final String reciverUserEmail;
  final String reciverUserID;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ChatController controller = Get.put(ChatController());

  sendMessage() async {
    if (controller.messageController.text.trim().isNotEmpty) {
      controller.sendMessage(widget.reciverUserID);
    }
    controller.messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.reciverUserEmail)),
      body: Column(
        children: [Expanded(child: buildMessageList()), buildMessageInput()],
      ),
    );
  }

  Widget buildMessageInput() {
    return Row(
      children: [
        Expanded(
            child: Input(
                controller: controller.messageController,
                hintText: "Xabar matnini yozish",
                obscureText: false)),
        IconButton(
          onPressed: () {
            sendMessage();
          },
          icon: const Icon(Icons.send),
        )
      ],
    );
  }

  Widget buildMessageList() {
    return StreamBuilder(
        stream: controller.getMessages(
            widget.reciverUserID, controller.firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error:${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loding....");
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => buildMessageItem(document))
                .toList(),
          );
        });
  }

  Widget buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var aligment =
        (data['senderId'] == controller.firebaseAuth.currentUser!.uid)
            ? Alignment.centerRight
            : Alignment.centerLeft;
    return Container(
      alignment: aligment,
      child: Column(
        children: [
          Text(data['senderEmail']),
          Text(data['message']),
        ],
      ),
    );
  }
}
