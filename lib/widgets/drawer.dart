import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:flutter_project005/pages/details_page.dart';
import 'package:flutter_project005/pages/details_example_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        // OR borderRadius: BorderRadius.only(
        //       topRight: Radius.circular(20),
        //       bottomRight: Radius.circular(20)),
      ),
      // NOTE: little children -> default constructor https://api.flutter.dev/flutter/widgets/ListView-class.html
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Example - Navigating to static page'),
            onTap: () {
              // close the drawer first
              Navigator.pop(context);

              // then navigate to the desired screen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return const DetailsExamplePage(
                      imagePath: 'assets/images/vn.png',
                      exampleCountryGetUrl:
                          'https://restcountries.com/v3.1/name/vietnam');
                }),
              );

              // TODO: need citation
              // NOTE: this is statelessw -> no need to perform Navigator async AND/OR check mounted
            },
          ),
          ListTile(
            title: const Text('Option Two'),
            // selected: _selectedIndex == 1,
            onTap: () {
              // Update the state of the app
              // _onItemTapped(1);
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
