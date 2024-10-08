import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                color: Color(0xFFEE353A),
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
                SizedBox(height: 4,),
                Text(
                  '• It has a search field to search songs.',
                  style: TextStyle(fontSize: 16),
                ),SizedBox(height: 4,),
                Text(
                  '• You can filter songs by media type criteria and result order criteria.',
                  style: TextStyle(fontSize: 16),
                ),SizedBox(height: 4,),
                Text(
                  '• By clicking the filter button, you can enable these filter options. Clicking it again removes all the applied filters and resets them to the default state.',
                  style: TextStyle(fontSize: 16),
                ),SizedBox(height: 4,),
                Text(
                  '• You can mark tracks as favorites by clicking the favorite icon on the list. ',
                  style: TextStyle(fontSize: 16),
                ),SizedBox(height: 4,),
                Text(
                  '• In the Favorite Tracks screen, you can view all your favorited tracks. You can also remove tracks from this list using the delete button.',
                  style: TextStyle(fontSize: 16),
                ),SizedBox(height: 4,),
                Text(
                  '• When you tap on a track in the list, a bottom sheet will open showing the MusicPlayerPage, where you can play, pause, or stop the music.',
                  style: TextStyle(fontSize: 16),
                ),SizedBox(height: 4,),
                Text(
                  '• The app uses shared preferences to store your favorite tracks and ensures that they persist even after restarting the app.',
                  style: TextStyle(fontSize: 16),
                ),SizedBox(height: 4,),
                Text(
                  '• The app supports background playback, so your music will continue to play even if you navigate away from the app.',
                  style: TextStyle(fontSize: 16),
                ),SizedBox(height: 4,),
                Text(
                  '• To ensure a smooth user experience, the app saves and restores your music playback state when you navigate back to the app.',
                  style: TextStyle(fontSize: 16),
                ),SizedBox(height: 4,),
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
                // Defining the URL to be launched
                final Uri url = Uri.parse('https://github.com/Jayapriyan-m/musix-flutter-app');

                // Checking if the URL can be launched
                if (await canLaunchUrl(url)) {
                  // Launching the URL if it's valid
                  await launchUrl(url);
                } else {
                  // Showing an error message if the URL couldn't be launched
                  Get.snackbar('Error', 'Could not launch $url',
                      snackPosition: SnackPosition.BOTTOM);
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