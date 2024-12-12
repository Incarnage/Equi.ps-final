import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/chat/chat_controller.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatRoom extends StatelessWidget {
   ChatRoom({super.key,
  required this.receiverEmail, required this.receiverID});

  final String receiverEmail;
  final String receiverID;
  final TextEditingController _messageController = TextEditingController();
  final Chatcontroller _chatcontroller = Chatcontroller();
  
  
  void sendMessage() async{
    if(_messageController.text.isNotEmpty){
      await _chatcontroller.sendMessage(receiverID, _messageController.text);

      _messageController.clear();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(title: Text(receiverEmail), showBackArrow: true,),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
      _buildUserMessage()
        ],
      ),
    );
  }

  Widget _buildMessageList(){
    String senderID = UserController.instance.user.value.id;
    return StreamBuilder(stream: _chatcontroller.getMessage(receiverID, senderID),
    builder: (context, snapshot){
      if(snapshot.hasError){
        return const Text("Error");
      }

      if(snapshot.connectionState == ConnectionState.waiting){
        return const Text("Loading...");
      }

      return ListView(
        children: snapshot.data!.docs.map((doc)=>_buildMessageItem(doc)).toList(),
      );
    });
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String,dynamic>;

    return Text(data['message']);
  }

  Widget _buildUserMessage(){
    return Row(
      children: [
        Expanded(child: TextField(controller: _messageController, decoration: const InputDecoration(labelText: "Type a message"), ),),
        IconButton(onPressed: sendMessage, icon: const Icon(Iconsax.send1))
      ],
    );
  }
}