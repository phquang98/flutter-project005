import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_project005/widgets/customform.dart';
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
  // NOTE: make this cleaner ?
  late String nameForm;
  late int ageForm;
  late String countryForm;
  late String genderForm;

  // simulate response that will be rendered late after fetching
  late Map<String, dynamic> lateData = {};

  // NOTE: make this cleaner ?
  void _updateFormData(String formDataOne, int formDataTwo,
      String formDataThree, String formDataFour) {
    setState(() {
      nameForm = formDataOne;
      ageForm = formDataTwo;
      countryForm = formDataThree;
      genderForm = formDataFour;
    });
  }

  Future<SlimCountry> fetchCountryDataByName() async {
    final response = await http.get(Uri.parse(widget.countryUrl));

    try {
      if (response.statusCode == 200) {
        List<dynamic> tmpList = jsonDecode(response.body);
        // https://restcountries.com/v3.1/name/mali -> firstWhere, not first
        final data = SlimCountry.fromJson(tmpList.firstWhere((ele) {
          // null check to not access undefined
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

  Future<dynamic> fakePost(String nameHere, int ageHere, String countryHere,
      String genderHere) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': nameHere,
        'age': ageHere,
        'country': countryHere,
        'gender': genderHere,
      }),
    );

    try {
      if (response.statusCode == 201) {
        var tmp = jsonDecode(response.body) as Map<String, dynamic>;
        setState(() {
          lateData = tmp;
        });
        // https://dart.dev/language/patterns#validating-incoming-json
        if (tmp
            case {
              'id': int idFoo,
              'name': String nameFoo,
              'age': int ageFoo,
              'country': String countryFoo,
              'gender': String genderFoo,
              // 'notExistKey': String,
            }) {
          log('A new way to null check + structure check + auto assign $idFoo $nameFoo $ageFoo $countryFoo $genderFoo');
        } else {
          log('A null value or structure does not match!');
        }

        return tmp;
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
  // - remember to handle null (user cancels the dialog (e.g. by hitting the back button on Android, or tapping on the space behind dialog))
  Future<int?> _dialogBuilder(BuildContext fncCtx) async {
    // type arg is the return type inside Nav.pop() when closed (e.g. int)
    return await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        // - very simple case
        // return AlertDialog(
        //   title: const Text('Basic dialog box.'),
        //   content: const Text('good'),
        //   actions: <Widget>[
        //     TextButton(
        //       onPressed: () {
        //         return Navigator.pop(fncCtx, 1);
        //       },
        //       child: const Text('Disabled'),
        //     ),
        //     TextButton(
        //       onPressed: () {
        //         return Navigator.pop(fncCtx, 2);
        //       },
        //       child: const Text('Enabled'),
        //     ),
        //   ],
        // );

        // - more complex case
        return SimpleDialog(
          title: const Text('text'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          children: <Widget>[
            SizedBox(
              width: 500,
              height: 500,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomForm(
                      updateFormData: _updateFormData,
                      closeFormHdlr: () {
                        return Navigator.pop(fncCtx, 69);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        // final cac =
                                        //     await _dialogBuilder(context);
                                        // log('data thay muon $cac');

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
                                          default:
                                            fakePost(nameForm, ageForm,
                                                countryForm, genderForm);
                                            break;
                                        }
                                      },
                                      child: const Text('Send data'),
                                    ),
                                    // kinda cond rendering
                                    () {
                                      if (lateData
                                          case {
                                            'id': int idFoo,
                                            'name': String nameFoo,
                                            'age': int ageFoo,
                                            'country': String countryFoo,
                                            'gender': String genderFoo,
                                          }) {
                                        return Text(
                                            'Data from backend: { id: $idFoo, name: $nameFoo, etc }');
                                      } else {
                                        return Container();
                                      }
                                    }(),
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
