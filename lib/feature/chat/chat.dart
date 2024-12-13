import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equips_v2/common/widgets/appbar/appbar.dart';
import 'package:equips_v2/feature/chat/chat_bubble.dart';
import 'package:equips_v2/feature/chat/chat_controller.dart';
import 'package:equips_v2/feature/personalize/controller/user_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatRoom extends StatefulWidget {
   ChatRoom({super.key,
  required this.receiverEmail, required this.receiverID});

  final String receiverEmail;
  
  final String receiverID;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _messageController = TextEditingController();

  final ChatController _chatcontroller = ChatController();

  FocusNode myFocusNode = FocusNode();

  @override
void initState(){
  super.initState();




  myFocusNode.addListener((){
    if(myFocusNode.hasFocus){
      Future.delayed(const Duration(milliseconds: 500),()=>scrollDown());
    }
  });

 
 Future.delayed(const Duration(milliseconds: 500), ()=> scrollDown());

  


}

 @override
  void dispose(){
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown(){
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void sendMessage() async{
    if(_messageController.text.isNotEmpty){
      await _chatcontroller.sendMessage(widget.receiverID,widget.receiverEmail, _messageController.text);

      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(title: Text(widget.receiverEmail), showBackArrow: true,),
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
    return StreamBuilder(stream: _chatcontroller.getMessage(widget.receiverID, senderID),
    builder: (context, snapshot){
      if(snapshot.hasError){
        return const Text("Error");
      }

      if(snapshot.connectionState == ConnectionState.waiting){
        return const Text("Loading...");
      }

      return ListView(
        controller: _scrollController,
        children: snapshot.data!.docs.map((doc)=>_buildMessageItem(doc)).toList(),
      );
    });
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String,dynamic>;

    bool isCurrentUser = data['senderID'] == UserController.instance.user.value.id;

    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;



    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: (data['message']), isCurrentUser: isCurrentUser)
        ],
      ));
  }

  Widget _buildUserMessage(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15, top:10),
      child: Row(
        children: [
          Expanded(child: TextField(focusNode: myFocusNode,controller: _messageController, decoration: const InputDecoration(labelText: "Type a message"), ),),
          Container(
            margin: const EdgeInsets.only(left: 15),
            decoration: const BoxDecoration(color: Color(0xFF25291C), shape: BoxShape.circle),
            child: IconButton(onPressed: sendMessage, icon: const Icon(Iconsax.send_2, color: Colors.white,)))
        ],
      ),
    );
  }
}