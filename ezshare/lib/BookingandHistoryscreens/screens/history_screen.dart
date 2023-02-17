import 'package:flutter/material.dart';
import 'package:ezshare/BookingandHistoryscreens/screens/first.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  TabBar get _tabbar => const TabBar(
        labelColor: Colors.black, //<-- selected text color
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.black,

        tabs: [
          Tab(
            child: Text(
              "Completed",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Tab(
            child: Text(
              "In-Progress",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Tab(
            child: Text(
              "Canceled",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Center(
                child: Text(
                  "History",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: _tabbar.preferredSize,
                child: ColoredBox(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: _tabbar,
                ),
              )),
          body: const TabBarView(children: [first(), first(), first()]),
        ));
  }
}
