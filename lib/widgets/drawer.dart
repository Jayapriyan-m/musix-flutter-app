import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musix/controllers/itune_controller.dart';
import 'package:musix/screens/about_page.dart';
import 'package:musix/widgets/countries_popup.dart';

class MusixDrawer extends StatelessWidget {
  const MusixDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ItunesController controller = Get.find<ItunesController>();
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
            Obx((){
              return ListTile(
                leading: Icon(Icons.language),
                title: Text('Current Region : ${controller.selectedCountry.value}'),
                onTap: () {
                  // if(controller.searchFieldController.text.isNotEmpty){
                  //   Get.back() ;
                  // }
                  Get.dialog(SelectCountry());
                },
              );
            }),
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
