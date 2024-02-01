// NOTE: all new page should be created like this
import 'package:flutter/material.dart';

import 'package:flutter_project005/widgets/drawer.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({super.key});

  @override
  State<TemplatePage> createState() => TemplatePageState();
}

class TemplatePageState extends State<TemplatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // widget is only available in statefulw
          title: const Text('This page\'s appbar text.'),
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
        ));
  }
}
