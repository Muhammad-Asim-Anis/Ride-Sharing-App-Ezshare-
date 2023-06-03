
import 'package:ezshare/Providers/searchprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController search = TextEditingController(); 
  @override
  Widget build(BuildContext context) {
    final searchprovider = Provider.of<SearchProvider>(context);
    return TextField(controller: search,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(width: 0, color: Color.fromARGB(255, 235, 235, 235)),
          borderRadius: BorderRadius.circular(13),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 235, 235, 235),
        hintText: "Find Here",
        // prefixIcon: Icon(CupertinoIcons.search),
      ),
      onChanged: (value) {
        searchprovider.setSearchvalue(value);
      },
    );
  }
}
