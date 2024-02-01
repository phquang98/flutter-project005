import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:flutter_project005/models/slim_country.dart';

class VerticalCard extends StatelessWidget {
  const VerticalCard({
    super.key,
    required this.countryRecord,
  });

  // TODO: how to make it private for later promotion https://dart.dev/tools/non-promotion-reasons#private
  // NOTE: currently handle null checking in child widget
  final SlimCountry? countryRecord;

  // Based on MD3 https://m3.material.io/components/cards/guidelines
  // Visual reference https://www.figma.com/file/1FJV3E5vygWE2ojJWccaVm/Material-3-Design-Kit-(Community)?type=design&node-id=52346-27569&mode=design&t=EybvKvppQe6tzv1Y-0
  @override
  Widget build(BuildContext context) {
    if (countryRecord != null) {
      log('data ne ${countryRecord?.commonName} ${countryRecord?.officialName}');
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // NOTE: to use Expanded, must be directly under Row/Column
        children: [
          // NOTE: recommended each rows represented by this, wrap it so change css stuffs later
          // Expanded(
          //   child: Container(
          //     // margin: const EdgeInsets.fromLTRB(8, 32, 8, 0),
          //     padding: const EdgeInsets.fromLTRB(8, 32, 8, 0),
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.blue,
          //         border: Border.all(
          //           color: Colors.black,
          //           width: 1,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          // First Row
          Container(
            margin: const EdgeInsets.fromLTRB(8, 32, 8, 8),
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Colors.black,
            //     width: 1,
            //   ),
            // ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Text(
                    countryRecord?.commonName ?? 'No Data',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  countryRecord?.officialName ?? 'No Data',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),

          // Second Row
          Image.network(
            countryRecord?.flagUrl ?? 'https://flagcdn.com/w320/un.png',
            // NOTE: must be same as parent card (vertical card width in details page)
            width: MediaQuery.of(context).size.width * 0.4,
            fit: BoxFit.fill,
          ),

          // Third Row - duplicate
          Container(
            margin: const EdgeInsets.fromLTRB(8, 32, 8, 0),
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Colors.black,
            //     width: 1,
            //   ),
            // ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                        child: const Text(
                          'Area',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '${NumberFormat.decimalPattern('vi_VN').format(countryRecord?.area ?? 0)} square km',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                        child: const Text(
                          'Population',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                          '${NumberFormat.compact().format(countryRecord?.population ?? 0 / 1000000)} million people'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Fourth Row - duplicate
          Container(
            margin: const EdgeInsets.fromLTRB(8, 32, 8, 0),
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Colors.black,
            //     width: 1,
            //   ),
            // ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                        child: const Text(
                          'Capital',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        countryRecord?.capitalName ?? 'No Data',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                        child: const Text(
                          'Region',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        countryRecord?.subregion ?? 'No Data',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Fourth Row - duplicate
          Container(
            margin: const EdgeInsets.fromLTRB(8, 32, 8, 0),
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Colors.black,
            //     width: 1,
            //   ),
            // ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                        child: const Text(
                          'Status',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '${countryRecord?.status[0].toUpperCase()}${countryRecord?.status.substring(1, countryRecord?.status.length)}',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                        child: const Text(
                          'Independence',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        countryRecord?.independent != null ? 'Yes' : 'No',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Fifth Row
          // Expanded(
          //   child: Container(
          //     margin: const EdgeInsets.fromLTRB(8, 32, 8, 0),
          //     child: Container(
          //       color: Colors.blue,
          //     ),
          //   ),
          // ),

          // END
          const Text(''),
        ],
      ),
    );
  }
}
