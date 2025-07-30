import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
          const SizedBox(height: 10),
          const Text(
            "Ahmed Hassan",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Text("Flutter Developer | Karachi"),
          const SizedBox(height: 20),
          const Divider(),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Friends"),
            trailing: Text("102"),
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text("Photos"),
            trailing: Text("48"),
          ),
        ],
      ),
    );
  }
}
