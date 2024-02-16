import 'package:flutter/material.dart';

class MemberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Members'),
      ),
      body: ListView(
        children: const [
          MemberListItem(
            name: 'LOY Socheat', 
            image: AssetImage('assets/socheat.jpg')
          ),
          MemberListItem(
            name: 'SAN Sengheang', 
            image: AssetImage('assets/sengheang.jpg')
          ),
          MemberListItem(
            name: 'LOEUK Vanarath', 
            image: AssetImage('assets/vanarath.jpg')
          ),
          MemberListItem(
            name: 'CHHOEM Thaileang', 
            image: AssetImage('assets/thaileang.jpg')
          ),
        ],
      ),
    );
  }
}

class MemberListItem extends StatelessWidget {
  final String name;
  final ImageProvider<Object> image;

  const MemberListItem({Key? key, required this.name, required this.image})
      : super(key: key);

@override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: image,
        ),
        title: Text(name),
      ),
    );
  }
}
