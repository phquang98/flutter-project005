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

  // Navigator
  // - initialized using a func like this (do explicit type arg, Dart type inference not as strong as TS)
  // - use Nav.pop()
  // - passed down to caller with async/await
  // - remember to handle null (user cancels the dialog (e.g. by hitting the back button on Android, or tapping on the mask behind the dialog))
  Future<int?> _dialogBuilder(BuildContext fncCtx) async {
    return await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Basic dialog box.'),
            content: const Text('good'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  return Navigator.pop(fncCtx, 1);
                },
                child: const Text('Disabled'),
              ),
              TextButton(
                onPressed: () {
                  return Navigator.pop(fncCtx, 2);
                },
                child: const Text('Enabled'),
              ),
            ],
          );
        });
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
        child: FutureBuilder<SlimCountry>(
          future: countryData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    // child: SizedBox(
                    //   width: MediaQuery.of(context).size.width * 0.4,
                    //   child: VerticalCard(
                    //     countryRecord: snapshot.data,
                    //   ),
                    // ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: SizedBox(
                              // width: MediaQuery.of(context).size.width * 0.4,
                              child: VerticalCard(
                                countryRecord: snapshot.data,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                              decoration: const BoxDecoration(
                                color: Colors.cyan,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        // uncomment to understand async/await
                                        // final cac =
                                        //     await _dialogBuilder(context);
                                        // log('cai nay chay truoc');
                                        // log('cai nay chay sau $cac');

                                        // Navigator
                                        // - control flow
                                        switch (await _dialogBuilder(context)) {
                                          case 1:
                                            log('pop tra ve 1');
                                            break;
                                          case 2:
                                            log('pop tra ve 2');
                                            break;
                                          case null:
                                            // dialog dismissed
                                            log('pop tra ve null');
                                            break;
                                        }
                                      },
                                      child: const Text('Send data'),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
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
