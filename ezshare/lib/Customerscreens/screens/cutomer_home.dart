import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Customerscreens/screens/customerhomedrawer.dart';
import 'package:ezshare/Customerscreens/screens/customerridecompletefeedback.dart';
import 'package:ezshare/Customerscreens/screens/dynamicridesdetail.dart';
import 'package:ezshare/Customerscreens/screens/first.dart';
import 'package:ezshare/Providers/authenticationprovider.dart';
import 'package:ezshare/phoneauthenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class customerhome extends StatefulWidget {
  final String userid;
  final String username;
  const customerhome({super.key, required this.userid, required this.username});

  @override
  State<customerhome> createState() => _customerhomeState();
}

// ignore: camel_case_types
class _customerhomeState extends State<customerhome> {
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
  FirebaseAuth auth = FirebaseAuth.instance;
  String cardid = "";
  bool isend = false;
  @override
  void initState() {
    super.initState();

    firebaseauthcheck();
    rideendcheck();
  }

  rideendcheck() async{
   await rides
        .where("rideendparticipants.${widget.userid}.CustomerId",
            isEqualTo: widget.userid)
        .get()
        .then((event) {
      for (var element in event.docs) {
        setState(() {
          cardid = element.id;
        });
      }
    });
   
   await rides.doc(cardid).get().then((event) async {
      Map<String, dynamic> enduser = event["rideendparticipants"];

      try {
        isend = enduser.containsKey(widget.userid);

        if (isend) {
          rides.doc(cardid).update({
            "users.${widget.userid}.start": false,
          });

          await Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.leftToRightWithFade,
                  child: CustomerRideCompleteFeedbackScreen(
                    fare: enduser.entries.firstWhere((element) => element.key == widget.userid).value["TotalFare"],
                    cardid: cardid,
                    imageurl: event["imageurl"],
                    riderid: event["Riderid"],
                    ridername: event["Ridername"],
                    userid: widget.userid,
                    username: widget.username,
                  )));

          // ignore: use_build_context_synchronously
        }
      } catch (e) {
        isend = false;
      }
    });
  }

  TabBar get _tabbar => const TabBar(
        labelColor: Color.fromARGB(255, 0, 157, 207),
        unselectedLabelColor: Colors.black,
        indicatorColor: Colors.transparent,
        tabs: [
          Tab(
            child: Text(
              "Scheduled",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Tab(
            child: Text(
              "Dynamic",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          )
        ],
      );
  loaddata(BuildContext context) {
    final authprovider = Provider.of<AuthenticationProvider>(context);
    authprovider.setuserID(widget.userid);
    authprovider.setuserName(widget.username);
  }

  firebaseauthcheck() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PhoneAuthenticateScreen(),
              ));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              iconTheme: const IconThemeData(
                color: Colors.blue,
              ),
              title: const Center(
                child: Text(
                  "Home",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: _tabbar.preferredSize,
                child: ColoredBox(
                  color: const Color.fromARGB(255, 217, 217, 217),
                  child: _tabbar,
                ),
              )),
          body: TabBarView(children: [
            first(
              userid: widget.userid,
              username: widget.username,
            ),
            DynamicRidesDetailScreen(
              userid: widget.userid,
              username: widget.username,
            ),
          ]),
          drawer: CustomerHomeDrawer(
              username: widget.username, userid: widget.userid),
        ));
  }
}
