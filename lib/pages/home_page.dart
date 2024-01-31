import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_project005/widgets/drawer.dart';
import 'package:flutter_project005/widgets/search_bar.dart';
import 'package:flutter_project005/models/slim_country.dart';
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
  // use this to hold data from backend
  late Future<List<SlimCountry>> dataFromFetchedBackend;
  // TODO: implement search
  // use this to hold data for render instead
  late List<SlimCountry> renderedData = [];
  late String searchPhrase;

  // for debugging
  // Future<dynamic> fetchCacDebugNgu() async {
  //   final response = await http
  //       .get(Uri.parse('https://restcountries.com/v3.1/name/Antarctica'));
  //   // final response = await http
  //   //     .get(Uri.parse('https://restcountries.com/v3.1/name/Vanuatu'));

  //   try {
  //     if (response.statusCode == 200) {
  //       List<dynamic> tmpList = jsonDecode(response.body);
  //       log('dit cu may $tmpList');
  //       final data =
  //           SlimCountry.fromJson(tmpList.first as Map<String, dynamic>);
  //       log('dit cu loz ${data.officialName}}');
  //     } else {
  //       throw Exception('Status code is not 200!');
  //     }
  //   } catch (e) {
  //     throw Exception('Something wrong!');
  //   }
  // }

  // TODO: sau khi viet xong, tim mau anh Huy xem anh viet ntn ve fetch fnc
  Future<List<SlimCountry>> fetchAllCountry() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    try {
      if (response.statusCode == 200) {
        List<dynamic> tmpList = jsonDecode(response.body);

        final dataArr = tmpList.map((ele) {
          // log('${ele['name']['common']}');
          return SlimCountry.fromJson(ele as Map<String, dynamic>);
        }).toList();

        return dataArr;
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
    // fetchCacDebugNgu();
    dataFromFetchedBackend = fetchAllCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // must have appbar to see drawer
      appBar: AppBar(
        // `widget` is only available in statefulw
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
                // color: Colors.blue,
                child: const CustomSearchBar(),
              ),
              Expanded(
                  // ListView must be under Expanded https://stackoverflow.com/a/57335217
                  child: Container(
                      color: Colors.yellow,
                      // TODO: giai thich type arg
                      child: FutureBuilder<List<SlimCountry>>(
                        future: dataFromFetchedBackend,
                        builder: (content, snapshot) {
                          if (snapshot.hasData) {
                            log('chan ly la day ${snapshot.data.toString()}');
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 10,
                              // NOTE: notice the null aw
                              itemBuilder: (context, index) {
                                return HorizontalCard(
                                  id: index,
                                  commonName:
                                      snapshot.data?[index].commonName ??
                                          'Loading',
                                  officialName:
                                      snapshot.data?[index].officialName ??
                                          'Loading',
                                  area: snapshot.data?[index].area ?? 0,
                                  population:
                                      snapshot.data?[index].population ?? 0,
                                  flagUrl: snapshot.data?[index].flagUrl ?? '',
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          return const CircularProgressIndicator();
                        },
                      )))
            ],
          )),
    );
  }
}
