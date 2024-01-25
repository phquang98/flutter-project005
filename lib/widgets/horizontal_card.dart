import 'dart:developer';

import 'package:flutter/material.dart';

class HorizontalCard extends StatelessWidget {
  const HorizontalCard(
      {super.key,
      required this.commonName,
      required this.officialName,
      required this.area,
      required this.flagSymbol,
      required this.population});

  final String commonName;
  final String officialName;
  final int area;
  final String flagSymbol;
  final int population;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: lam not chuyen huong sang trang details o day
      },
      child: Center(
        child: Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              log('ne');
              Navigator.of(context).pushNamed('/test_details_example');
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Image.asset(
                      'assets/images/vn.png',
                    ),
                    title: Text(commonName),
                    subtitle: Text(officialName),
                    onTap: () {
                      log('ListTile have default ink splash effect!');
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}