
import 'package:flutter/material.dart';


class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
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
    );
  }
}
