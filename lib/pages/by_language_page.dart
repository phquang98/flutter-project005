import 'package:flutter/material.dart';

import 'package:flutter_project005/widgets/drawer.dart';

class ByLanguagePage extends StatefulWidget {
  const ByLanguagePage({super.key, required this.appBarText});

  final String appBarText;

  @override
  State<ByLanguagePage> createState() => _ByLanguagePageState();
}

class _ByLanguagePageState extends State<ByLanguagePage> {
  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // `widget` is only available in statefulw
        title: Text('Country App - ${widget.appBarText}'),
      ),
      drawer: const CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
