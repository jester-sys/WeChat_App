import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent
        ,
        title: Row(
          children: [
            Text('Updates'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.add_circled_solid),
          ),

        ],
      ),
      body: Center(
        child: Text('Update Page'),
      ),
    );
  }
}