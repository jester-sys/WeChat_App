import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_chat/helper/EditingController.dart';
import 'package:we_chat/model/ChatUserModel.dart';
import 'package:we_chat/utils/Dialogs.dart';

import '../api/Apis.dart';
import '../auth/loginScreen.dart';
import '../utils/ShowBottomSheet.dart';


// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

//profile screen -- to show signed in user info
class ProfileScreen extends StatefulWidget {
  final ChatUserModel user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // for hiding keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //app bar
          appBar: AppBar(title: const Text('Profile Screen')),

          //floating button to log out
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton.extended(
                backgroundColor: Colors.redAccent,
                onPressed: () async {
                  //for showing progress dialog
                  CustomDialogs.showprogressBar(context);

                  // await APIs.updateActiveStatus(false);

                  //sign out from app
                  await APIs.auth.signOut().then((value) async {
                    await GoogleSignIn().signOut().then((value) {
                      //for hiding progress dialog
                      Navigator.pop(context);

                      //for moving to home screen
                      Navigator.pop(context);

                      APIs.auth = FirebaseAuth.instance;

                      //replacing home screen with login screen
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>  LoginScreen()));
                    });
                  });
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout')),
          ),

          //body
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // for adding some space
                    SizedBox(width: 20, height: 40),

                    //user profile picture
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.yellowAccent, // Border color
                           width: 2, // Border width
    ),
    ),
                      child: Stack(
                        children: [

                          //profile picture
                          _image != null
                              ?


                          //local image
                          ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: Image.file(File(_image!),
                                  width:140,
                                  height: 140,
                                  fit: BoxFit.cover))
                              :

                          //image from server
                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(90),
                            child: CachedNetworkImage(
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                              imageUrl: widget.user.image,
                              errorWidget: (context, url, error) =>
                              const CircleAvatar(
                                  child: Icon(CupertinoIcons.person)),
                            ),
                          ),

                          //edit image button
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 80,
                            child: MaterialButton(
                              elevation: 1,
                              onPressed: () {
                                _showBottomSheet();
                              },
                              shape: const CircleBorder(),
                              color: Colors.white,
                              child: const Icon(CupertinoIcons.add_circled_solid, color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),

                    // for adding some space
                    SizedBox(height: 20),

                    // user email label
                    Text(widget.user.email,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 16)),

                    // for adding some space
                    SizedBox(height: 20),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Background color
                        borderRadius: BorderRadius.circular(10.0), // Border radius
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      margin: EdgeInsets.only(top: 20,right: 10,left: 10),
                      child: TextFormField(
                        initialValue: widget.user.name,
                        onSaved: (val) => APIs.me.name = val ?? '',
                        validator: (val) => val != null && val.isNotEmpty
                            ? null
                            : 'Required Field',

                        decoration: InputDecoration(
                          hintText: 'Enter The Phone Number',
                          border: InputBorder.none, // Hide the default border
                          icon: Icon(CupertinoIcons.ant_circle_fill),
                        ),
                      ),
                    ),

                    // for adding some space

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Background color
                        borderRadius: BorderRadius.circular(10.0), // Border radius
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      margin: EdgeInsets.only(top: 20,right: 10,left: 10),
                      child: TextFormField(
                         initialValue: widget.user.about,
                         onSaved: (val) => APIs.me.about = val ?? '',
                          validator: (val) => val != null && val.isNotEmpty
                             ? null
                             : 'Required Field',

                        decoration: InputDecoration(
                          hintText: 'Enter The Phone Number',
                          border: InputBorder.none, // Hide the default border
                          icon: Icon(CupertinoIcons.person_alt),
                        ),
                      ),
                    ),


                    // for adding some space
                    SizedBox(height:10),

                    // update profile button
                    // ElevatedButton.icon(
                    //   style: ElevatedButton.styleFrom(
                    //       shape: const StadiumBorder(),
                    //       minimumSize: Size(30, 30)),
                    //   onPressed: () {
                    //     if (_formKey.currentState!.validate()) {
                    //       _formKey.currentState!.save();
                    //       APIs.updateUserInfo().then((value) {
                    //         CustomDialogs.showSnackbar(
                    //             context, 'Profile Updated Successfully!');
                    //       });
                    //     }
                    //   },
                    //   icon: const Icon(Icons.edit, size: 28),
                    //   label:
                    //   const Text('UPDATE', style: TextStyle(fontSize: 16)),
                    // )
                                 Container(
               width: 400,
               height: 50,
               child: Padding(
                 padding: const EdgeInsets.only(top: 5,right: 10,left: 10),
                 child: ElevatedButton(
                   onPressed: () {
                     if (_formKey.currentState!.validate()) {
                         _formKey.currentState!.save();
                         APIs.updateUserInfo().then((value) {
                           CustomDialogs.showSnackbar(
                           context, 'Profile Updated Successfully!');
                         });
                     }
                     },

                   style: ElevatedButton.styleFrom(
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10.0), // Set border radius here
                     ),
                     elevation: 5, // Set elevation here
                     backgroundColor: Colors.blue, // Set background color here
                   ),
                   child: Text(
                     "Save",
                     style: TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.w500,
                       fontSize: 18,
                     ),
                   ),
                 ),
               )
                                 )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  // bottom sheet for picking a profile picture for user
  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding:
            EdgeInsets.only(top: 30, bottom:30),
            children: [
              //pick profile picture label
              const Text('Pick Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),

              //for adding some space
              SizedBox(height: 30),

              //buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      // Pick an image.
                      final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
                      if (image != null) {
                        Navigator.pop(context);
                        setState(() {
                          _image = image.path;
                        });
                        APIs.updateProfilePicture(File(_image!));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: CircleBorder(),
                      fixedSize: Size(80, 150),
                    ),
                    child: Image.asset('assets/images/add_image.png'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      // Capture a photo.
                      final XFile? photo =
                      await picker.pickImage(source: ImageSource.camera,imageQuality: 80);
                      if (photo != null) {
                        setState(() {
                          _image = photo.path;
                        });
                        APIs.updateProfilePicture(File(_image!));

                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: CircleBorder(),
                      fixedSize: Size(80, 150),
                    ),
                    child: Image.asset('assets/images/camera.png'),
                  )
                ],
              )
            ],
          );
        });
  }
}
// class ProfileScreens extends StatefulWidget{
//   final ChatUserModel user;
//   const ProfileScreens({Key? key, required this.user}) : super(key: key);
//
//
//   static TextEditingController _textFirstNameEditingController = TextEditingController(text:  APIs.auth.currentUser!.displayName);
//   static TextEditingController _textEmailEditingController = TextEditingController(text:  APIs.auth.currentUser!.email);
//   static TextEditingController _textBioEditingController = TextEditingController(text:  "I am Felling So Happy I become Software Engineer");
//   static TextEditingController _textPhoneEditingController = TextEditingController(text:  "+918595788159");
//   static TextEditingController _textLastEditingController = TextEditingController(text:  "Yadav");
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenStates extends State<ProfileScreen> {
//
//   final _formKey = GlobalKey<FormState>();
//   String? _image;
//   @override
//   Widget build(BuildContext context) {
//  return GestureDetector(
//    onTap: () => FocusScope.of(context).unfocus() ,
//    child: Scaffold(
//      backgroundColor: Colors.white,
//      appBar: AppBar(
//        backgroundColor: Colors.white,
//        title: Row(
//        children: [
//        Text('Your Profile')
//       ],
//       )
//      ),
//      body: Form(
//        child: SingleChildScrollView(
//          child: Column(
//            children: [
//
//              ClipRRect(
//                borderRadius: BorderRadius.circular(90),
//                child: Container(
//                  width: 94, // Increased width to account for border width
//                  height: 94, // Increased height to account for border width
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(90),
//                    border: Border.all( // Border properties
//                      color: Colors.blue, // Border color
//                      width: 2, // Border width
//                    ),
//                  ),
//                  child: Stack(
//                    children: [
//                      // Image or placeholder
//                      _image != null
//                          ? ClipRRect(
//                        borderRadius: BorderRadius.circular(70), // Adjust the value according to your preference
//                        child: Image.file(
//                          File(_image!),
//                          // Use BoxFit.cover to display the full image
//                          fit: BoxFit.cover,
//                          width: double.infinity,
//                          height: double.infinity,
//                        ),
//                      )
//                          : ClipRRect(
//                        borderRadius: BorderRadius.circular(70), // Adjust the value according to your preference
//                        child: CachedNetworkImage(
//                          imageUrl: APIs.auth.currentUser!.photoURL.toString(),
//                          errorWidget: (context, url, error) =>
//                              CircleAvatar(child: Icon(CupertinoIcons.person)),
//                          fit: BoxFit.cover,
//                          width: double.infinity,
//                          height: double.infinity,
//                        ),
//                      ),
//                      // Icon
//                      Positioned(
//                        top: 50,
//                        left: 30,
//                        child: MaterialButton(
//                          onPressed: () {
//                            showBottomSheet();
//                          },
//                          child: Icon(
//                            CupertinoIcons.add_circled_solid,
//                            color: Colors.blue,
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//
//
//              Container(
//                decoration: BoxDecoration(
//                  color: Colors.grey[200], // Background color
//                  borderRadius: BorderRadius.circular(10.0), // Border radius
//                ),
//                padding: EdgeInsets.symmetric(horizontal: 16.0),
//                margin: EdgeInsets.only(top: 20,right: 20,left: 20),
//                child: TextFormField(
//                  onSaved: (val) => APIs.me.about = val ?? '',
//                  validator: (val) => val != null && val.isNotEmpty ? null :"Required Field",
//                  // controller: ProfileScreen._textBioEditingController,
//                  initialValue: widget.user.about,
//                  decoration: InputDecoration(
//                    hintText: 'Enter The Bio',
//                    border: InputBorder.none, // Hide the default border
//                    icon: Icon(CupertinoIcons.person_fill)
//
//                  ),
//                ),
//              ),
//              Container(
//                decoration: BoxDecoration(
//                  color: Colors.grey[200], // Background color
//                  borderRadius: BorderRadius.circular(10.0), // Border radius
//                ),
//                padding: EdgeInsets.symmetric(horizontal: 16.0),
//                margin: EdgeInsets.only(top: 20,right: 20,left: 20),
//                child: TextFormField(
//                  onSaved: (val) => APIs.me.name = val ?? '',
//                  validator: (val) => val != null && val.isNotEmpty ? null :"Required Field",
//                  initialValue: widget.user.name,
//                  decoration: InputDecoration(
//                    hintText: 'Enter The Name',
//                    border: InputBorder.none, // Hide the default border
//                    icon: Icon(CupertinoIcons.person),
//                  ),
//                ),
//              ),
//              Container(
//                decoration: BoxDecoration(
//                  color: Colors.grey[200], // Background color
//                  borderRadius: BorderRadius.circular(10.0), // Border radius
//                ),
//                padding: EdgeInsets.symmetric(horizontal: 16.0),
//                margin: EdgeInsets.only(top: 20,right: 20,left: 20),
//                child: TextFormField(
//                  // onSaved: (val) => APIs.Me.LastName = val ?? '',
//                  // validator: (val) => val != null && val.isNotEmpty ? null :"Required Field",
//                  controller: ProfileScreen._textLastEditingController,
//                  decoration: InputDecoration(
//                    hintText: 'Enter The Name',
//                    border: InputBorder.none, // Hide the default border
//                    icon: Icon(CupertinoIcons.person),
//                  ),
//                ),
//              ),
//              Container(
//                decoration: BoxDecoration(
//                  color: Colors.grey[200], // Background color
//                  borderRadius: BorderRadius.circular(10.0), // Border radius
//                ),
//                padding: EdgeInsets.symmetric(horizontal: 16.0),
//                margin: EdgeInsets.only(top: 20,right: 20,left: 20),
//                child: TextFormField(
//                  // onSaved: (val) => APIs.Me.Number = val ?? '',
//                  // validator: (val) => val != null && val.isNotEmpty ? null :"Required Field",
//                  controller: ProfileScreen._textPhoneEditingController,
//                  decoration: InputDecoration(
//                    hintText: 'Enter The Phone Number',
//                    border: InputBorder.none, // Hide the default border
//                    icon: Icon(CupertinoIcons.phone),
//                  ),
//                ),
//              ),
//
//              SizedBox(
//                height: 20,
//              ),
//              Container(
//                width: 400,
//                height: 50,
//                child: Padding(
//                  padding: const EdgeInsets.only(top: 5,right: 10,left: 10),
//                  child: ElevatedButton(
//                    onPressed: () {
//                      if (_formKey.currentState!.validate()) {
//                        _formKey.currentState!.save();
//                        APIs.getSelfInfo().then((_) { // Fetch the latest user info
//                          APIs.updateUserInfo().then((_) {
//                            CustomDialogs.showSnackbar(context, "Profile Updated Successfully");
//                          }).catchError((error) {
//                            CustomDialogs.showSnackbar(context, "Failed to update profile: $error");
//                          });
//                        }).catchError((error) {
//                          CustomDialogs.showSnackbar(context, "Failed to fetch user info: $error");
//                        });
//                      } else {
//                        CustomDialogs.showSnackbar(context, "Please correct the errors");
//                      }
//                    },
//                    style: ElevatedButton.styleFrom(
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10.0), // Set border radius here
//                      ),
//                      elevation: 5, // Set elevation here
//                      backgroundColor: Colors.blue, // Set background color here
//                    ),
//                    child: Text(
//                      "Save",
//                      style: TextStyle(
//                        color: Colors.white,
//                        fontWeight: FontWeight.w500,
//                        fontSize: 18,
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//
//
//
//            ],
//          ),
//        ),
//      ),
//
//    ),
//  );
//   }
//   void showBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       builder: (_) {
//         return ListView(
//           shrinkWrap: true,
//           padding: EdgeInsets.only(top: 20, bottom: 20),
//           children: [
//             Text(
//               'Pick Profile Picture',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     final ImagePicker picker = ImagePicker();
//                     // Pick an image.
//                     final XFile? image =
//                     await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
//                     if (image != null) {
//                       Navigator.pop(context);
//                       setState(() {
//                         _image = image.path;
//                       });
//                       APIs.updateProfilePicture(File(_image!));
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     shape: CircleBorder(),
//                     fixedSize: Size(80, 150),
//                   ),
//                   child: Image.asset('assets/images/add_image.png'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () async {
//                     final ImagePicker picker = ImagePicker();
//                     // Capture a photo.
//                     final XFile? photo =
//                     await picker.pickImage(source: ImageSource.camera,imageQuality: 80);
//                     if (photo != null) {
//                       setState(() {
//                         _image = photo.path;
//                       });
//                       APIs.updateProfilePicture(File(_image!));
//
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     shape: CircleBorder(),
//                     fixedSize: Size(80, 150),
//                   ),
//                   child: Image.asset('assets/images/camera.png'),
//                 )
//               ],
//             )
//           ],
//         );
//       },
//     );
//   }
// }