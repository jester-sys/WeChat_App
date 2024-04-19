import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/api/Apis.dart';
import 'package:we_chat/helper/MyDate_Utils.dart';
import 'package:we_chat/model/MessageModel.dart';

class MessageCard extends StatefulWidget{
  final MessageModel messageModel;

  MessageCard({super.key,required this.messageModel});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.messageModel.fromId
        ? _greenMessage()
        : _blueMessage();
  }
    Widget _blueMessage(){

    if(widget.messageModel.read.isEmpty){
      APIs.updateMessageReadStatus(widget.messageModel);
    }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Flexible(
          child: Container(
            padding:  EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 245, 34, 34),

              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),

              )
            ),
            child: Text(
              widget.messageModel.msg,
              style: TextStyle(fontSize: 15,color: Colors.black87),
            ),
          ),
        ) ,
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child:        Text(MyDateUtils.getFormattedTime(context: context, time: widget.messageModel.sent),
            style: TextStyle(fontSize: 13,color: Colors.black54),),
          )

        ],
      );
    }
    Widget _greenMessage(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Row(
            children: [
              SizedBox(width: 5,),
              if(widget.messageModel.read.isNotEmpty)
              Icon(CupertinoIcons.check_mark,color: Colors.blue,size: 20,),
              SizedBox(width: 2,),
              Text(MyDateUtils.getFormattedTime(context: context, time: widget.messageModel.sent),
                style: TextStyle(fontSize: 13,color: Colors.black54),),
            ],
          ),
          Flexible(
            child: Container(
              padding:  EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20
              ),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 218, 255, 176),

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),)),

              child: Text(
                widget.messageModel.msg,
                style: TextStyle(fontSize: 15,color: Colors.black87),
              ),
            ),
          ) ,
        ],
      );
    }

}

