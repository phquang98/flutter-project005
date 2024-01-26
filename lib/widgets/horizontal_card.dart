import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:flutter_project005/pages/details_page.dart';

class HorizontalCard extends StatelessWidget {
  const HorizontalCard({
    super.key,
    required this.commonName,
    required this.officialName,
    required this.area,
    required this.population,
    required this.flagUrl,
  });

  final String commonName;
  final String officialName;
  final int area;
  final int population;
  final String flagUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          // TODO: move this to parent ?
          // use async to perform actions after done naving
          onTap: () async {
            // 1. use simple example to understand nav first
            // await Navigator.of(context).pushNamed(
            //   '/test_details_example',
            //   arguments: {'accountName': 'Johnny', 'userId': '6969'},
            // );
            // // simulate actions
            // log('Received result from SecondScreen:');

            // 2. then uncomment this
            // TODO: fix this
            final fullUrl = 'https://restcountries.com/v3.1/name/$commonName';
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      DetailsPage(commonName: commonName, countryUrl: fullUrl)),
            );
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Image.network(
                    flagUrl,
                  ),
                  title: Text(commonName),
                  subtitle: Text(officialName),
                  // onTap: () {
                  //   log('ListTile have default ink splash effect when have onTap!');
                  // },
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    // Expanded must be under Row or Column
                    children: [
                      Expanded(
                          child: Text(
                        'Area: $area',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                      Expanded(
                          child: Text(
                        'Population: $population',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
