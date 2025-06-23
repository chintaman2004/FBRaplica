import 'package:fbreplica/post_pic.dart';
import 'package:flutter/material.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsApp Business'),
        actions: [
          IconButton(icon: const Icon(Icons.camera_alt), onPressed: () {}),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
      body: Container(
        color: Colors.grey[250],
        child: ListView(
          children: [
            postpic(
              title: 'Ali Chintman',
              description: 'Business account',
              tilcolor: Colors.greenAccent,
              img: "assets/images/bmw.jpg",
            ),
            postpic(
              title: 'Umer Farooq',
              description: 'Personal account',
              tilcolor: Colors.blueAccent,
              img: "assets/images/Subaru.png",
            ),
            postpic(
              title: 'Iqbal Paya',
              color: Colors.blueGrey,
              description: 'personal account',
              tilcolor: Colors.blueGrey[300],
              img: "assets/images/Lamb.png",
            ),
            customWidget(
              title: 'Abdul Sattar',
              color: Colors.red,
              description: 'personal account',
              tilcolor: Colors.redAccent,
              img: "assets/images/Nissan.png",
            ),
          ],
        ),
      ),
    );
  }
}
