import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_project005/models/slim_country.dart';
import 'package:flutter_project005/widgets/vertical_card.dart';

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
        // https://restcountries.com/v3.1/name/mali -> firstWhere, not first
        final data = SlimCountry.fromJson(tmpList.firstWhere((ele) {
          // add another null check to not accessing undefined
          return (ele['name'] != null &&
              ele['name']['common'] == widget.commonName);
        }) as Map<String, dynamic>);
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
        title: Text('Details Page - ${widget.commonName}'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: VerticalCard(
                        commonName: snapshot.data?.commonName ?? 'Loading',
                        officialName: snapshot.data?.officialName ?? 'Loading',
                        population: snapshot.data?.population ?? 0,
                        flagUrl: snapshot.data?.flagUrl ?? 'Loading',
                        independent: snapshot.data?.independent ?? false,
                        status: snapshot.data?.status ?? 'Loading',
                        capitalName: snapshot.data?.capitalName ?? 'Loading',
                        subregion: snapshot.data?.subregion ?? 'Loading',
                        area: snapshot.data?.area ?? 0,
                        currencyName: snapshot.data?.currencyName ?? 'Loading',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  )
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
