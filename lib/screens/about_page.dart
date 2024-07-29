import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'MusiX',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255,252,32,65),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Music Player App',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Version 1.0',
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Text(
              'About the App:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'This is an iTunes integrated music app. It does not contain full audio tracks; only previews are available.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
          Text(
            'User Manual:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
            SizedBox(height: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '• At the start of the app, it will show random top artists\' hits.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• It has a search field to search songs.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• You can filter songs by media type criteria and result order criteria.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• By clicking the filter button, you can enable these filter options. Clicking it again removes all the applied filters and resets them to the default state.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
            SizedBox(height: 16),
            // Text(
            //   'Future Plans:',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            // Text(
            //   'In upcoming versions, more functionalities will be added.',
            //   style: TextStyle(fontSize: 16),
            // ),
            // SizedBox(height: 16),
            Text(
              'Developer:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Jayapriyan'),
              subtitle: Text('Flutter Developer'),
            ),
            SizedBox(height: 16),
            Text(
              'Contact Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('jayapriyan11802@gmail.com'),
            ),
            SizedBox(height: 16),
            Text(
              'Project Repository:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () async {
                final Uri url = Uri.parse('https://github.com/Jayapriyan-m/musix-flutter-app');
                if (await canLaunchUrl(url)) {
                await launchUrl(url);
                } else {
                throw 'Could not launch $url';
                }
              },
              child: Text('GitHub Repo'),
            ),
            SizedBox(height: 16),
            Text(
              '© 2024 MusiX. All rights reserved.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}