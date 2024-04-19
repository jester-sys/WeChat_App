import 'package:flutter/cupertino.dart';

import '../api/Apis.dart';

class EditingController{
   static TextEditingController _textFirstNameEditingController = TextEditingController(text:  APIs.auth.currentUser!.displayName);
   static TextEditingController _textEmailEditingController = TextEditingController(text:  APIs.auth.currentUser!.email);
}