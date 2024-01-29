import 'package:flutter/material.dart';

import 'package:flutter_project005/widgets/drawer.dart';
import 'package:flutter_project005/widgets/search_bar.dart';
import 'package:flutter_project005/widgets/horizontal_card.dart';
import 'package:flutter_project005/pages/details_example_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.appBarText});

  final String appBarText;

  @override
  State<HomePage> createState() => _HomePageState();
}

//  TODO:
//  - add search bar
//  - add logic to filter data based on input
//    - add state between page and widgets
//    - find how to transfer state from pages -> widgets
//    - write actions to rerender each time searchbar value(?) changed
class _HomePageState extends State<HomePage> {
  // TODO: change this to fetching data instead
  final fakeDataCommonName = ['United Kingdom', 'France', 'Viet Nam'];
  final fakeDataOfficialName = [
    'United Kingdom of Great Britain and Northern Ireland',
    'French Republic',
    'Socialist Republic of Vietnam'
  ];
  final fakeDataArea = [242900, 551695, 331212];
  final fakeDataPop = [67215293, 67391582, 97338583];
  final fakeDataFlagUrls = [
    'https://flagcdn.com/w320/gb.png',
    'https://flagcdn.com/w320/fr.png',
    'https://flagcdn.com/w320/vn.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // must have appbar to see drawer
      appBar: AppBar(
        // widget is only available in statefulw
        title: Text('Home Page - ${widget.appBarText}'),
      ),
      drawer: const CustomDrawer(),
      // recommended start wrapping a Container in all pages -> give consistence padding
      body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.only(bottom: 16),
                color: Colors.blue,
                child: const CustomSearchBar(),
              ),
              Expanded(
                  // ListView must be under Expanded https://stackoverflow.com/a/57335217
                  child: Container(
                color: Colors.yellow,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return HorizontalCard(
                      commonName: fakeDataCommonName[index],
                      officialName: fakeDataOfficialName[index],
                      area: fakeDataArea[index],
                      population: fakeDataPop[index],
                      flagUrl: fakeDataFlagUrls[index],
                    );
                  },
                ),
              ))
            ],
          )),
    );
  }
}
