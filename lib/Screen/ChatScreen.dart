import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:we_chat/api/Apis.dart';
import 'package:we_chat/model/ChatUserModel.dart';


import '../model/MessageModel.dart';
import '../widgets/message_card.dart';

class ChatScreen extends StatefulWidget{
  ChatUserModel user;
  ChatScreen({super.key,required this.user});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<MessageModel> list=[];
  final textController  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 245, 255),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: _appBar(),
        actions: [
          IconButton(

            icon: Icon(CupertinoIcons.phone_circle_fill), onPressed: () {

          },),
          IconButton(

            icon: Icon(CupertinoIcons.bars)
            , onPressed: () {

          },),

        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: APIs.getAllMessage(widget.user),
              builder: (context, snapshot) {
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return SizedBox();
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    // final list = [];
                    // list.add(value)
                    list = data?.map((e) => MessageModel.fromJson(e.data()))
                    .toList() ??
                        [];

                    if(list.isNotEmpty) {
                      return ListView.builder(
                          padding: EdgeInsets.only(top: .02),
                          itemCount: list.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return MessageCard(messageModel: list[index],);
                          });
                    }
                    else{
                      return Center(
                        child: Text('Say Hii! 👋 ',style: TextStyle(fontSize: 20),),
                      );
                    }
                }
              },
            ),
          ),
          _chatInput(),
        ],
      ),

    );
  }

  Widget _appBar() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: InkWell(
        onTap: () {

        },
        child: Row(
          children: [
            IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(CupertinoIcons.arrow_left, color: Colors.black,)),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                width: 40,
                height: 40,
                imageUrl: widget.user.image,
                errorWidget: (context, url, error) =>
                    CircleAvatar(child: Icon(CupertinoIcons.person_alt),),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name, style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500
                ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text('Last seen not available', style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
                ),


              ],
            )
          ],
        ),
      ),
    );
  }


  Widget _chatInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 5),
      child: Row(
        children: [
          IconButton(onPressed: () {
            chatShowBottomSheet();
          },
              icon: Icon(
                CupertinoIcons.add, color: Colors.blueAccent, size: 24,)),
          Expanded(child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200], // Background color
              borderRadius: BorderRadius.circular(10.0),),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            margin: EdgeInsets.only(right: 5),
            child: TextField(
              controller: textController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Enter The Name',
                border: InputBorder.none,
              ),
            ),
          ),
          ),
          MaterialButton(onPressed: () {
            if(textController.text.isNotEmpty){
              APIs.sendMessage(widget.user,textController.text);
              textController.text = '';
            }
          },
            minWidth: 0,
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
            shape: CircleBorder(),
            color: Colors.green,
            child: Icon(CupertinoIcons.location_fill)
            ,)


        ],
      ),
    );
  }
  void chatShowBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 20, bottom: 20),
          children: [
            // Text(
            //   'Pick Profile Picture',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: CircleBorder(),
                    fixedSize: Size(80, 150),
                  ),
                  child: Icon(CupertinoIcons.rectangle_fill_on_rectangle_angled_fill),
                ),
                ElevatedButton(
                  onPressed: () async {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: CircleBorder(),
                    fixedSize: Size(80, 150),
                  ),
                  child: Icon(CupertinoIcons.smiley),
                ),
                ElevatedButton(
                  onPressed: () async {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: CircleBorder(),
                    fixedSize: Size(80, 150),
                  ),
                  child: Icon(CupertinoIcons.camera),
                )
              ],
            )
          ],
        );
      },
    );
  }
}