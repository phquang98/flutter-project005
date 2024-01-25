import 'package:flutter/material.dart';

import 'package:flutter_project005/widgets/drawer.dart';
import 'package:flutter_project005/widgets/horizontal_card.dart';
import 'package:flutter_project005/pages/details_example_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.appBarText});

  final String appBarText;

  @override
  State<HomePage> createState() => _HomePageState();
}

// TODO: add search box in this page, to show later how to filter and reponse live, and search box are used only here atm
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // must have appbar to see drawer
      appBar: AppBar(
        // widget is only available in statefulw
        title: Text(widget.appBarText),
      ),
      drawer: const CustomDrawer(),
      // recommended start wrapping a Container in all pages -> give consistence padding
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (context, index) {
            return const HorizontalCard(
                commonName: 'Viet Nam',
                officialName: 'CHXHCN Viet Nam',
                area: 1234,
                flagSymbol: '🇻🇳',
                population: 7890);
          },
        ),
      ),
      // body: Center(
      //     child: ElevatedButton(
      //   child: const Text('Xem VN'),
      //   onPressed: () {
      //     // 2 ways for navigating
      //     // - Navigator.of(context).push() if widget ctx is being exposed (aka here, inside Widget build(BuildContext context))
      //     // - Navigator.push() if handle nav logic outside widget
      //     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      //       return const DetailsExamplePage(
      //           imagePath: 'assets/images/vn.png',
      //           exampleCountryGetUrl:
      //               'https://restcountries.com/v3.1/name/vietnam');
      //     }));
      //   },
      // )),
    );
  }
}
