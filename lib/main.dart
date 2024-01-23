import 'package:flutter/material.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: HomePage(pageTitle: 'This is a home page'),
    );
  }
}
