import 'package:flutter/material.dart';
import 'package:flutter_project005/pages/details_example_page.dart';

import 'package:flutter_project005/pages/home_page.dart';
import 'package:flutter_project005/widgets/drawer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    // use this for Scaffold, e.g. https://stackoverflow.com/a/60455813
    return const MaterialApp(
      debugShowCheckedModeBanner: true,
      // home: HomePage(appBarText: 'This is an app bar text'),
      home: DetailsExamplePage(
        imagePath: 'assets/images/vn.png',
      ),
    );
  }
}
