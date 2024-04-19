

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat/model/ChatUserModel.dart';
import 'package:we_chat/model/MessageModel.dart';

class APIs{
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firebase = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;




//for Storing Self Information
  static ChatUserModel me = ChatUserModel(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      about: "Hey, I'm using We Chat!",
      image: user.photoURL.toString(),
      createdAt: '',
      isOnline: false,
      lastActive: '',
      pushToken: '');

  // to return current User
  static User get user => auth.currentUser!;




//for checking if user exists or not ?
static Future<bool> userExists() async{
  return (await firebase.collection('users').doc(user.uid).get()).exists;
}

  static Future<void> getSelfInfo() async {
    await firebase.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUserModel.fromJson(user.data()!);
        log('My Data: ${user.data()}');
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  // for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUserModel(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey, I'm using We Chat!",
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');

    return await firebase
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }
static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser(){
  return firebase
      .collection('users')
       .where('id', isNotEqualTo: user.uid)
      .snapshots();
  }
  // static Future<void> updateUserInfo() async {
  //   await firebase.collection('users').doc(user.uid).update({
  //      'name': Me.name,
  //      'about': Me.about,
  //      'LastName': Me.LastName,
  //         'PhoneNumber': Me.Number,
  //
  //
  //    }
  //
  //    );
  // }
  // for updating user information
  // for updating user information
  static Future<void> updateUserInfo() async {
    await firebase.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

  static Future<void> updateProfilePicture(File file)async {

  final ext = file.path.split('.').last;
  final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');
  await ref.putFile(file,SettableMetadata(contentType: 'image/$ext'));

  me.image = await ref.getDownloadURL();
  await firebase.collection('users')
  .doc(user.uid)
  .update({
    'image':  me.image
  });
  }

  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessage(
      ChatUserModel chatUserModel
      ){
    return    firebase.collection('chats/${getConversationID(chatUserModel.id)}/message/').snapshots();
  }
  static Future<void> sendMessage(ChatUserModel userModel ,String msg) async{
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    // message to send
    final MessageModel message =MessageModel(told: userModel.id, msg: msg, read: '', type: Type.text,
        fromId: user.uid, sent: time);
    final ref  = firebase
    .collection('chats/${getConversationID(userModel.id)}/message/');
    await ref.doc(time).set(message.toJson());
  }
  //update read status of message
  static Future<void> updateMessageReadStatus(MessageModel messageModel) async{
    firebase.collection('chats/${getConversationID(messageModel.fromId)}/message/')
        .doc(messageModel.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(ChatUserModel user){
    return firebase.collection('chats/${getConversationID(user.id)}/messages')
    .orderBy('sent',descending: true)
        .limit(2)
        .snapshots();
  }


}