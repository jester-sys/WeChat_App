

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../api/Apis.dart';
import '../../model/ChatUserModel.dart';
import '../../widgets/ChatUserCard.dart';

class ChatsPage extends StatefulWidget {
  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  List<ChatUserModel> list = [];
  final List<ChatUserModel> _searchList =[];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if(_isSearching){
            setState(() {
              _isSearching = false;
            });
            return Future.value(false);
          }
          else{
            return Future.value(true);
          }

        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: _isSearching
                ? Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Background color
                borderRadius: BorderRadius.circular(10.0), // Border radius
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              margin: EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (val) {
                  _searchList.clear();
                  for (var i in list) {
                    if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                        i.email.toLowerCase().contains(val.toLowerCase())) {
                      _searchList.add(i);
                      setState(() {
                        _searchList;
                      });
                    }
                  }

                 // Update the state after search list is updated
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  icon: Icon(CupertinoIcons.search),
                ),
              ),
            )
                : Text('We Chat'),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  icon: Icon(_isSearching
                      ? CupertinoIcons.clear_circled_solid
                      : CupertinoIcons.search)),

            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              // Add floating action button functionality here
            },
            child: Icon(
              CupertinoIcons.chat_bubble_2_fill,
              color: Colors.white,
            ),
            backgroundColor: Colors.blue,
          ),
          body: Column(
            children: [

              Expanded(
                child: StreamBuilder(
                  stream: APIs.getAllUser(),
                  builder: (context, snapshot) {
                    switch(snapshot.connectionState){
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        list  = data?.map((e) => ChatUserModel.fromJson(e.data())).toList() ?? [];


                        if(list.isNotEmpty) {
                          return ListView.builder(
                              itemCount:_isSearching? _searchList.length :  list.length,
                              padding: EdgeInsets.only(top: .02),
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ChatUserCard(user:_isSearching? _searchList[index] : list[index],);
                              });
                        }
                        else{
                          return Center(
                            child: Text('No Connections Fond!',style: TextStyle(fontSize: 20),),
                          );
                        }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}