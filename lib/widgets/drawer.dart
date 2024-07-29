import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/screens/about_page.dart';

class MusixDrawer extends StatelessWidget {
  const MusixDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Bat Man'),
              accountEmail: Text('batman@dc.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/batman.jpeg'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Get.to(AboutPage());
              },
            ),
          ],
        )
    );
  }
}
