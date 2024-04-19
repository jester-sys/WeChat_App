import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/MoreScreen/ProfileScreen.dart';
import 'package:we_chat/utils/Dialogs.dart';

import '../../api/Apis.dart';
import '../../model/ChatUserModel.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    APIs.auth.currentUser?.uid.toString();
    ChatUserModel chatUserModel;
    var widget;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text('More'),
          ],
        ),

      ),
      body: Column(
        children: [


                 ListTile(
                      leading:  ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: CachedNetworkImage(
                          width: 45,
                          height: 45,
                          imageUrl:   APIs.auth.currentUser!.photoURL.toString(),
                          // placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget:  (context, url,error) => CircleAvatar(child: Icon(CupertinoIcons.person)),
                        ),
                      ),
                      title: Text(
                        APIs.auth.currentUser!.displayName.toString(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        APIs.auth.currentUser!.email.toString(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                      trailing: Transform.rotate(
                        angle: -3.14,
                        child: Icon(CupertinoIcons.back),
                      ),

                 ),

              SizedBox(
                height: 20,
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProfileScreen(user: APIs.me,)),
                  );
                },


              child: ListTile(
                leading: Icon(CupertinoIcons.person), // Use Icon widget instead of backgroundImage

                title: Text('Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                trailing:Transform.rotate(
                  angle: -3.14, // Specify the angle of rotation, in radians
                  child: Icon(CupertinoIcons.back,size: 20,),
                ),
                            ),
              ),


      ListTile(
              leading: Icon(CupertinoIcons.chat_bubble,), // Use Icon widget instead of backgroundImage
              title: Text('Chats', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              trailing:Transform.rotate(
                angle: -3.14, // Specify the angle of rotation, in radians
                child: Icon(CupertinoIcons.back,size: 20,),
              ),
            ),


         ListTile(
              leading: Icon(CupertinoIcons.sun_max), // Use Icon widget instead of backgroundImage
              title: Text('Appearance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              trailing:Transform.rotate(
                angle: -3.14, // Specify the angle of rotation, in radians
                child: Icon(CupertinoIcons.back),
              ),
            ),


        ListTile(
              leading: Icon(CupertinoIcons.bell),
    // Use Icon widget instead of backgroundImage
              title: Text('Notification', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              trailing:Transform.rotate(
                angle: -3.14, // Specify the angle of rotation, in radians
                child: Icon(CupertinoIcons.back,size: 20,),
              ),
            ),


       ListTile(
              leading: Icon(CupertinoIcons.shield),// Use Icon widget instead of backgroundImage
              title: Text('Privacy', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              trailing: Icon(CupertinoIcons.chevron_forward,size: 20,),

            ),


           ListTile(
              leading: Icon(CupertinoIcons.folder), // Use Icon widget instead of backgroundImage
              title: Text('Data Usage', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              trailing: Icon(CupertinoIcons.chevron_forward,size: 20,),

            ),
          InkWell(
            onTap: (){
              CustomDialogs.showAlertDialog(context);
            },
            child: ListTile(
              leading: Icon(  CupertinoIcons.square_arrow_left), // Use Icon widget instead of backgroundImage
              title: Text('Sign O0ut', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              trailing:Transform.rotate(
                angle: -3.14, // Specify the angle of rotation, in radians
                child: Icon(CupertinoIcons.back),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Divider(
              color: Colors.grey, // Set the color of the line
              thickness: 1, // Set the thickness of the line
              height: 20, // Set the height of the line
            ),
          ),

          ListTile(
              leading: Icon(CupertinoIcons.question_circle),
          // Use Icon widget instead of backgroundImage
              title: Text('Help', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              trailing: Icon(CupertinoIcons.chevron_forward,size: 20,),

            ),


          ListTile(
              leading: Icon(CupertinoIcons.mail), // Use Icon widget instead of backgroundImage
              title: Text('invite Your friend', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              trailing: Icon(CupertinoIcons.chevron_forward,size: 20,),

            ),


        ],
      )
    );
  }
}