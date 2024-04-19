
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/api/Apis.dart';
import 'package:we_chat/widgets/ChatUserCard.dart';

import 'ChatScreen.dart';
import 'MoreScreen.dart';
import 'UpdateScreen.dart';





class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    UpdatesPage(),
    ChatsPage(),
    MorePage(),
  ];

  final List<String> _labels = ['Contacts', 'Chats', 'More'];
  final List<IconData> _icons = [
    CupertinoIcons.chart_bar_fill,
    CupertinoIcons.chat_bubble_fill,
    CupertinoIcons.person_alt_circle_fill,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(
          _labels.length,
              (index) => BottomNavigationBarItem(
            icon: Icon(_icons[index]),
            label: _labels[index],
          ),
        ),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Change the color as per your requirement
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}




// class HomeScreen extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     return _HomeScreen();
//   }
// }
//
// class _HomeScreen extends State<HomeScreen>{
//     List<ChatUserModel> list = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      appBar: AppBar(
//        leading: Icon(CupertinoIcons.home),
//        title: Text('We Chat',),
//        actions: [
//          IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.search)),
//          IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.ellipsis_vertical,))
//        ],
//      ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(bottom: 10,left: 10),
//         child: FloatingActionButton(onPressed: () async {
//           await APIs.auth.signOut();
//           await GoogleSignIn().signOut();
//         },child: Icon(CupertinoIcons.conversation_bubble,),),
//       ),
//       body: StreamBuilder(
//         stream: APIs.firebase.collection('users').snapshots(),
//         builder: (context, snapshot) {
//           switch(snapshot.connectionState){
//             case ConnectionState.waiting:
//             case ConnectionState.none:
//               return const Center(child: CircularProgressIndicator());
//             case ConnectionState.active:
//             case ConnectionState.done:
//               final data = snapshot.data?.docs;
//               list  = data?.map((e) => ChatUserModel.fromJson(e.data())).toList() ?? [];
//
//
//               if(list.isNotEmpty) {
//                 return ListView.builder(
//                     itemCount: list.length,
//                     padding: EdgeInsets.only(top: .02),
//                     physics: BouncingScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return ChatUserCard(user: list[index],);
//                     });
//               }
//               else{
//                return Text('No Connections Fond!',style: TextStyle(fontSize: 20),);
//               }
//           }
//
//         },
//       )
//     );
//   }
//
// }