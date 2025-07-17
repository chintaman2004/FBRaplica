// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1877F2),
        title: const Text(
          "facebook",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 10),
          Icon(Icons.message),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/mini.jpg',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 16,
                  bottom: -40,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/ahc.jpg'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Text(
              "AHMED HASSAN",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text("@ahmedhassan", style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 10),

            // ✅ Button Row with Dynamic Vertical Divider
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.phone),
                    label: const Text("Call Now"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1877F2),
                    ),
                  ),
                  const VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                    width: 20,
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.message),
                    label: const Text("Send Message"),
                  ),
                ],
              ),
            ),

            const Divider(height: 30),

            // Tabs
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  tabItem("Home"),
                  tabItem("Reviews"),
                  tabItem("Photos"),
                  tabItem("Videos"),
                  tabItem("Posts"),
                  tabItem("Events"),
                  tabItem("About"),
                  tabItem("Community"),
                ],
              ),
            ),

            const Divider(height: 20),

            sectionTitle("Recommendations and Reviews"),
            reviewItem(
              avatar: 'assets/images/reviewer1.jpg',
              name: "Karen Naide",
              date: "January 7, 2012",
              review:
                  "I've been working a lot with Karen Naide on a new venture called 60 Second University and have come ...",
            ),
            reviewItem(
              avatar: 'assets/images/reviewer2.jpg',
              name: "Jamie",
              date: "November 22, 2014",
              review:
                  "Jamie has consistently been tops in his content, and in particular his knowledge and predictions of ...",
            ),

            const Divider(height: 20),
            sectionTitle("Community"),
            communityStat(
              Icons.thumb_up_alt_outlined,
              "2,112 people like this",
            ),
            communityStat(Icons.group_outlined, "2,365 people follow this"),
            communityStat(Icons.location_on_outlined, "3 check-ins"),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget tabItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Center(
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget reviewItem({
    required String avatar,
    required String name,
    required String date,
    required String review,
  }) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: AssetImage(avatar)),
      title: Text(review),
      subtitle: Text(date),
      trailing: const Icon(Icons.star, color: Colors.orange),
    );
  }

  Widget communityStat(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(text)],
      ),
    );
  }
}
