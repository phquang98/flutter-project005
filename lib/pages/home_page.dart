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
            return HorizontalCard(
              commonName: fakeDataCommonName[index],
              officialName: fakeDataOfficialName[index],
              area: fakeDataArea[index],
              population: fakeDataPop[index],
              flagUrl: fakeDataFlagUrls[index],
            );
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
