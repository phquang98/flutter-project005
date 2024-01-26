import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_project005/models/slim_country.dart';

/// Simple example of writing a widget with visual rendered based on fetching data
/// - only fetch 1 record inside 1 array (https://restcountries.com/v3.1/name/vietnam)
class DetailsExamplePage extends StatefulWidget {
  const DetailsExamplePage(
      {super.key, required this.imagePath, required this.exampleCountryGetUrl});

  // use final for widget's fields
  final String imagePath;
  final String exampleCountryGetUrl;

  @override
  State<DetailsExamplePage> createState() => _DetailsExamplePageState();
}

class _DetailsExamplePageState extends State<DetailsExamplePage> {
  // late: will give value before using, but at a later time
  late Future<SlimCountry> textCountryData;

  /// Fetch and convert data from JSON -> built-in Dart types -> /models
  Future<SlimCountry> fetchExampleCountry() async {
    // 1. Fetch and return Res obj
    final response = await http.get(Uri.parse(widget.exampleCountryGetUrl));
    // log('Status code: ${response.statusCode}');
    log('Response: ${response.body}');

    // 2. Control flow accordingly
    try {
      if (response.statusCode == 200) {
        // log('Request success.');
        // 3. Decode JSON to built-in Dart type (List, as API commnly returns an arr)
        List<dynamic> tmpList = jsonDecode(response.body);

        // 4. Use class mets for casting
        // if endpoint returns [record]
        // final dataInOne =
        //     SlimCountry.fromJson(tmpList.first as Map<String, dynamic>);
        // if endpoint returns [record1, record2, ...]
        final dataInMany = SlimCountry.fromJson(tmpList.firstWhere((element) {
          // NOTE: cant type-check element, improve this ?
          return element['name']['common'] == 'Vietnam';
        }) as Map<String, dynamic>);

        // Simulating a parsing err -> catch
        // final jsonData = jsonDecode('Non-JSON Response');

        // return dataInOne;
        return dataInMany;
      } else {
        throw Exception('Status code is not 200!');
      }
    } catch (err) {
      log('Exception: $err');
      throw Exception('Something wrong!');
    }
  }

  /// recommended only assign value for widget state in here -> make it single source of truth for initialization
  @override
  void initState() {
    super.initState();
    textCountryData = fetchExampleCountry();
  }

  @override
  Widget build(BuildContext context) {
    // access data passed from Navigation (check null before casting)
    final nullableParams = ModalRoute.of(context)?.settings.arguments;

    if (nullableParams != null) {
      // if data existed, try casting to Map for later usage
      var mappedParams = nullableParams as Map<String, String>;
      log('Data passed from nav: { accountName: ${mappedParams['accountName']}, userId: ${mappedParams['userId']} }');
    } else {
      log('that bai');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Example Widget'),
        // `leading` will have default value (https://api.flutter.dev/flutter/material/AppBar-class.html)
        leading: SizedBox(
          height: 50,
          width: 50,
          child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.black,
              )),
        ),
      ),
      // recommended start wrapping a Container in all pages -> give consistence padding
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder(
            future: textCountryData,
            builder: ((context, snapshot) {
              // if async ops completes and server returns sth
              if (snapshot.hasData) {
                // snapshot.data still can be nullable as what if server returns null (e.g. find a non-existed record)
                return Column(
                  children: [
                    Row(
                      children: [
                        Text('Nước ${snapshot.data?.commonName}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(widget.imagePath, fit: BoxFit.cover)
                      ],
                    ),
                    Row(
                      children: [
                        Text('Tên chính thức: ${snapshot.data?.officialName}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500])),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Dân số: ${snapshot.data?.population}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500])),
                      ],
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            })),
      ),
    );
  }
}
