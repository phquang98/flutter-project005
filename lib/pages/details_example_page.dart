import 'package:flutter/material.dart';

class DetailsExamplePage extends StatefulWidget {
  const DetailsExamplePage({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<DetailsExamplePage> createState() => _DetailsExamplePageState();
}

class _DetailsExamplePageState extends State<DetailsExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // widget is only available in statefulw
        title: Text('Trang vi du: nuoc VN'),
      ),
      body: Column(
        children: <Widget>[
          const Text('Nước Việt Nam',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Image.asset(widget.imagePath, fit: BoxFit.cover),
          // if use Colors with value, don't make it const https://stackoverflow.com/a/56495179
          Text('Socialist Republic of Vietnam',
              style: TextStyle(color: Colors.grey[500])),
        ],
      ),
    );
  }
}
