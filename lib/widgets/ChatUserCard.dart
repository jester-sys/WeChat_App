
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/Screen/ChatScreen.dart';
import 'package:we_chat/api/Apis.dart';
import 'package:we_chat/helper/MyDate_Utils.dart';
import 'package:we_chat/model/ChatUserModel.dart';
import 'package:we_chat/model/MessageModel.dart';

class ChatUserCard extends StatefulWidget{
  final ChatUserModel user;

  const ChatUserCard({super.key, required this.user});

  // const ChatUserCard(super.key,required this.userModel);
  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  MessageModel? messageModel;
//hgjhjhgfjhgjg
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 0.5,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user)));
        },
        child: StreamBuilder(
          stream: APIs.getLastMessage(widget.user),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final list = data?.map((e) => MessageModel.fromJson(e.data())).toList() ?? [];
            if (list.isNotEmpty) {
              messageModel = list[0];
            }
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: CachedNetworkImage(
                  width: 45,
                  height: 45,
                  imageUrl: widget.user.image,
                  errorWidget: (context, url, error) => CircleAvatar(child: Icon(Icons.person)),
                ),
              ),
              title: Text(widget.user.name),
              subtitle: Text(
                messageModel != null ? messageModel!.msg : widget.user.about,
                maxLines: 1,
              ),
              trailing: messageModel == null
                  ? null
                  : messageModel!.read.isEmpty && messageModel!.fromId != APIs.user.uid
                  ? Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.green.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
              )
                  : Text(
                MyDateUtils.getLastMessageTime(context: context, time: messageModel!.sent),
                style: TextStyle(color: Colors.black),
              ),
            );
          },
        ),
      ),
    );
  }
}