import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_project005/widgets/drawer.dart';
import 'package:flutter_project005/models/slim_country.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {super.key, required this.commonName, required this.countryUrl});

  final String commonName;
  final String countryUrl;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Future<SlimCountry> countryData;

  Future<SlimCountry> fetchCountryDataByName() async {
    final response = await http.get(Uri.parse(widget.countryUrl));

    try {
      if (response.statusCode == 200) {
        List<dynamic> tmpList = jsonDecode(response.body);
        final data =
            SlimCountry.fromJson(tmpList.first as Map<String, dynamic>);
        return data;
      } else {
        throw Exception('Status code is not 200!');
      }
    } catch (e) {
      throw Exception('Something wrong!');
    }
  }

  @override
  void initState() {
    super.initState();
    countryData = fetchCountryDataByName();
  }

  // TODO: viet bua cac data linh tinh vao trong future builder de test, sau do so sanh voi cach anh Huy viet future builder ntn
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.commonName),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: FutureBuilder(
          future: countryData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text('${snapshot.data?.commonName}'),
                  Text('${snapshot.data?.officialName}'),
                  Text('${snapshot.data?.population}'),
                  Text('${snapshot.data?.flagPng}'),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
