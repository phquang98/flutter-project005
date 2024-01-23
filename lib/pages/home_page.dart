import 'package:flutter/material.dart';

import 'package:flutter_project005/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.pageTitle});

  final String pageTitle;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // must have appbar to see drawer
      appBar: AppBar(
        // widget is only available in statefulw
        title: Text(widget.pageTitle),
      ),
      drawer: const CustomDrawer(),
      body: const Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
