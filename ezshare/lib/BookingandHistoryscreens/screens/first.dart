// ignore_for_file: avoid_unnecessary_containers, camel_case_types

import 'package:ezshare/BookingandHistoryscreens/widgets/history_card.dart';
import 'package:ezshare/Customerscreens/widgets/search_field.dart';
import 'package:flutter/material.dart';


class first extends StatefulWidget {
  const first({super.key});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              child: const SearchField(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: const HistoryCard(),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
