// ignore_for_file: avoid_unnecessary_containers, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/BookingandHistoryscreens/screens/reciept_screen.dart';
import 'package:ezshare/BookingandHistoryscreens/widgets/history_card.dart';

import 'package:flutter/material.dart';

class CompletedRidesScreen extends StatefulWidget {
  final String userid;
  final String username;
  const CompletedRidesScreen(
      {super.key, required this.userid, required this.username});

  @override
  State<CompletedRidesScreen> createState() => _CompletedRidesScreenState();
}

class _CompletedRidesScreenState extends State<CompletedRidesScreen> {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: wallet
                .where("participants",
                    arrayContainsAny: [widget.userid, getcancelbyid()])
                .where("status", isEqualTo: "Completed")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Expanded(
                  child:
                      Center(child: Text("No Complete rides Recipt Avaliable")),
                );
              }

              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot walletdetails =
                          snapshot.data!.docs[index];

                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecieptScreen(
                                      walletdeduction:
                                          walletdetails["remainbalance"],
                                      distance: walletdetails["Distance"],
                                      seats: walletdetails["Seats"],
                                      cost: walletdetails["Fare"],
                                      drivername: walletdetails["username"],
                                      numberplate:
                                          walletdetails["Number plate"],
                                      startdate: walletdetails["startdate"],
                                      userendlocation:
                                          walletdetails["Userendlocation"],
                                      userstartlocation:
                                          walletdetails["Userstartlocation"],
                                      vehicleName: walletdetails["Vehicle"],
                                      vehicletype:
                                          walletdetails["Vehicletype"]),
                                ));
                          },
                          child: HistoryCard(
                            cost: walletdetails["Fare"],
                            endtime: walletdetails["Date"],
                            startdate: walletdetails["startdate"],
                            totaltime: walletdetails["Total Time"],
                            userendlocation: walletdetails["Userendlocation"],
                            userstartlocation:
                                walletdetails["Userstartlocation"],
                          ));
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
