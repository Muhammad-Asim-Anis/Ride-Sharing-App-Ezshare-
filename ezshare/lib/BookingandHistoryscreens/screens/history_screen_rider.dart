import 'package:ezshare/BookingandHistoryscreens/screens/cencelrides.dart';
import 'package:ezshare/BookingandHistoryscreens/screens/completedrides.dart';
import 'package:ezshare/BookingandHistoryscreens/screens/inprogressridesrider.dart';
import 'package:flutter/material.dart';


class HistoryRiderScreen extends StatefulWidget {
  final String userid;
  final String username;
  const HistoryRiderScreen(
      {super.key, required this.userid, required this.username});

  @override
  State<HistoryRiderScreen> createState() => _HistoryRiderScreenState();
}

class _HistoryRiderScreenState extends State<HistoryRiderScreen> {
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
              iconTheme: const IconThemeData(
                color: Colors.blue,
              ),
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
          body: TabBarView(children: [
            CompletedRidesScreen(
                userid: widget.userid, username: widget.username),
            InprogressRidesRiderScreen(
                userid: widget.userid, username: widget.username),
            CancelRidesScreen(userid: widget.userid, username: widget.username)
          ]),
        ));
  }
}
