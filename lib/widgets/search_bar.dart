import 'dart:developer';
import 'package:flutter/material.dart';

// TODO: create another search bar based on Huy's code `_searchBarKHANG` and see the diff
class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.onChangeHandler,
  });

  final void Function(String) onChangeHandler;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        builder: (BuildContext context, SearchController ctrler) {
      return SearchBar(
        controller: ctrler,
        onChanged: (value) {
          // log('log value $value');
          widget.onChangeHandler(value);
        },
        onTap: () {
          // disable the auto-complete list in suggestionBuilder
          // ctrler.openView();
        },
        leading: const Icon(Icons.search),
      );
    }, suggestionsBuilder: (BuildContext context, SearchController ctrler) {
      // var cac = List.generate(3, (index) {
      //   final String suggestItem = 'item $index';

      //   return ListTile(
      //     title: Text(suggestItem),
      //     onTap: () {},
      //   );
      // });

      return [];
    });
  }
}
