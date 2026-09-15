import 'package:flutter/material.dart';

void main() { runApp(JolaApp()); }

class JolaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'JOLA', debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFFE53935), scaffoldBackgroundColor: Color(0xFF0A0A0A), brightness: Brightness.dark),
      home: MainScreen());
  }
}

class MainScreen extends StatefulWidget { @override _MainScreenState createState() => _MainScreenState(); }

class _MainScreenState extends State<MainScreen> {
  int _idx = 0;
  final screens = [ChatsScreen(), StatusScreen(), LoveScreen(), ContactsScreen(), MeScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('JOLA LAVA 🔥', style: TextStyle(fontWeight: FontWeight.w900)), backgroundColor: Color(0xFFE53935)),
      body: screens[_idx],
      bottomNavigationBar: BottomNavigationBar(currentIndex: _idx, onTap: (i)=>setState(()=>_idx=i), type: BottomNavigationBarType.fixed, backgroundColor: Color(0xFF1A1A1A), selectedItemColor: Color(0xFFE53935), unselectedItemColor: Colors.grey, items: [
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
        BottomNavigationBarItem(icon: Icon(Icons.circle), label: 'Status'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Love'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Contacts'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
      ]),
    );
  }
}

class ChatsScreen extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return ListView(children: [
      chatTile(context, 'Jo - Soweto', 'Molo! When you coming?', 'J'),
      chatTile(context, 'La - PTA', 'Video call later?', 'L', color: Colors.blue),
      chatTile(context, 'Thabo', 'My car pic', 'T', color: Colors.grey),
      chatTile(context, 'Zanele, 24 - Soweto', 'Accepted invite! NEW', 'Z', color: Colors.pink),
    ]);
  }
  Widget chatTile(BuildContext ctx, String name, String msg, String letter, {Color color=const Color(0xFFE53935)}) {
    return ListTile(leading: CircleAvatar(backgroundColor: color, child: Text(letter, style: TextStyle(fontWeight: FontWeight.bold))), title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(msg, style: TextStyle(color: Colors.grey)), onTap: ()=>Navigator.push(ctx, MaterialPageRoute(builder: (_)=>ChatDetail(name: name))));
  }
}

class ChatDetail extends StatefulWidget { final String name; ChatDetail({required this.name}); @override _ChatDetailState createState() => _ChatDetailState(); }

class _ChatDetailState extends State<ChatDetail> {
  final _ctrl = TextEditingController(); List<String> msgs = ['Hey! JOLA is LIVE!', 'Sharp! Built from Soweto!'];
  void _send() { if (_ctrl.text.trim().isEmpty) return; setState(()=>msgs.add(_ctrl.text)); _ctrl.clear(); }
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.name), backgroundColor: Color(0xFF1F1F1F), actions: [IconButton(icon: Icon(Icons.videocam), onPressed: ()=>showDialog(context: context, builder: (_)=>AlertDialog(title: Text('JOLA VIDEO HD'), content: Text('Video call to ${widget.name} coming - Agora SDK ready'))))]), body: Column(children: [
      Expanded(child: ListView(children: msgs.map((m)=>Align(alignment: m.contains('LIVE')? Alignment.centerLeft : Alignment.centerRight, child: Container(margin: EdgeInsets.all(6), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: m.contains('LIVE')? Color(0xFF333333) : Color(0xFFE53935), borderRadius: BorderRadius.circular(16)), child: Text(m)))).toList())),
      Padding(padding: EdgeInsets.all(8), child: Row(children: [Expanded(child: TextField(controller: _ctrl, decoration: InputDecoration(hintText: 'Message...', filled: true, fillColor: Color(0xFF2A2A2A), border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none)))), IconButton(icon: Icon(Icons.send, color: Color(0xFFE53935)), onPressed: _send)]))
    ]));
  }
}

class StatusScreen extends StatelessWidget { @override Widget build(BuildContext context) { return Center(child: Text('Status - Tap + to add video')); } }
class LoveScreen extends StatelessWidget { @override Widget build(BuildContext context) { return Center(child: Text('Love Invites - Zanele nearby')); } }
class ContactsScreen extends StatelessWidget { @override Widget build(BuildContext context) { return Center(child: Text('Contacts - Invite friends')); } }
class MeScreen extends StatelessWidget { @override Widget build(BuildContext context) { return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [CircleAvatar(radius:40, backgroundColor: Color(0xFFE53935), child: Text('Y', style: TextStyle(fontSize:30))), SizedBox(height:10), Text('Founder - Soweto'), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE53935)), onPressed: (){}, child: Text('Premium R29/mo'))])); } }
