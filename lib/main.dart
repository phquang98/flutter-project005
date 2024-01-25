import 'package:flutter/material.dart';

import 'package:flutter_project005/widgets/drawer.dart';
import 'package:flutter_project005/pages/home_page.dart';
import 'package:flutter_project005/widgets/horizontal_card.dart';
import 'package:flutter_project005/pages/details_example_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    // use this for Scaffold, e.g. https://stackoverflow.com/a/60455813
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        // home: HomePage(appBarText: 'This is an app bar text'),
        // home: HorizontalCard(
        //     commonName: 'Viet Nam',
        //     officialName: 'CHXHCN Viet Nam',
        //     area: 1234,
        //     flagSymbol: '🇻🇳',
        //     population: 7890),
        // home: ListView.builder(
        //   scrollDirection: Axis.vertical,
        //   itemCount: 3,
        //   itemBuilder: (context, index) {
        //     return const HorizontalCard(
        //         commonName: 'Viet Nam',
        //         officialName: 'CHXHCN Viet Nam',
        //         area: 1234,
        //         flagSymbol: '🇻🇳',
        //         population: 7890);
        //   },
        // ),
        home: const HomePage(appBarText: 'This is an app bar text'),
        routes: {
          '/test_details_example': (context) {
            return const DetailsExamplePage(
                imagePath: 'assets/images/vn.png',
                exampleCountryGetUrl:
                    'https://restcountries.com/v3.1/name/vietnam');
          }
        });
  }
}
