// ignore_for_file: avoid_unnecessary_containers, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/BookingandHistoryscreens/widgets/canceledridecard.dart';
import 'package:flutter/material.dart';

class CancelRidesScreen extends StatefulWidget {
  final String userid;
  final String username;
  const CancelRidesScreen(
      {super.key, required this.userid, required this.username});

  @override
  State<CancelRidesScreen> createState() => _CancelRidesScreenState();
}

class _CancelRidesScreenState extends State<CancelRidesScreen> {
  CollectionReference wallet =
      FirebaseFirestore.instance.collection("Wallet_Recipt");
  String cancelid = "";

  String getcancelbyid() {
    wallet
        .where("userId", isEqualTo: widget.userid)
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        setState(() {
          cancelid = element["id"];
        });
      }
    });

    return cancelid;
  }

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
          StreamBuilder(
            stream: wallet.where("participants",
                arrayContainsAny: [widget.userid, getcancelbyid()]).where("Check",isEqualTo: "Penalty").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("");
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Expanded(child:  Center(child: Text("No Started Ride Avaliable")));
              }

              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot walletdeatils =
                          snapshot.data!.docs[index];
                      return CanceledRideCard(
                        cancelby: walletdeatils["Cencel by"],
                        dateafter:
                            walletdeatils["Date"].toString().substring(0, 10),
                        endpoint: walletdeatils["Userendlocation"],
                        startingpoint: walletdeatils["Userstartlocation"],
                        timeafter: walletdeatils["Date"],
                      );
                    }),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
