// ignore_for_file: avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Customerscreens/screens/customerhomedrawer.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  final String userid;
  final String username;
  const WalletScreen({super.key, required this.userid, required this.username});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  CollectionReference wallet =
      FirebaseFirestore.instance.collection("Wallet_Recipt");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.blue,
        ),
        centerTitle: true,
        title: const Text(
          "Wallet",
          style: TextStyle(
              color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            StreamBuilder(
              stream:
                  wallet.where("userId", isEqualTo: widget.userid).snapshots(),
              builder: (context, snapshot) {
                int totalbalance = 0;
                if (snapshot.data != null) {
                  for (var index = 0;
                      index < snapshot.data!.docs.length;
                      index++) {
                    int amount = 0, fare = 0;
                    final DocumentSnapshot walletdetails =
                        snapshot.data!.docs[index];
                    amount = walletdetails["Amount"];
                    fare = walletdetails["Fare"];
                    totalbalance += amount - fare;
                  }
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 14),
                            child: Text(
                              "Balance Rs: $totalbalance",
                              style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        color: Colors.grey.shade200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Container(
                              child: const Center(
                                  child: Text(
                                "Date",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                            )),
                            Expanded(
                                child: Container(
                              child: const Center(
                                  child: Text(
                                "Fare",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                            )),
                            Expanded(
                                child: Container(
                              child: const Center(
                                  child: Text(
                                "Amount",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                            )),
                            Expanded(
                                child: Container(
                              child: const Center(
                                  child: Text(
                                "Balance",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                            ))
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot walletdetails =
                              snapshot.data!.docs[index];

                          return Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Container(
                                  child: Center(
                                      child: Text(
                                    "${walletdetails["Date"]} \n ${walletdetails["Check"]}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  )),
                                )),
                                Expanded(
                                    child: Container(
                                  child: Center(
                                      child: Text(
                                    "${walletdetails["Fare"]}",
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                )),
                                Expanded(
                                    child: Container(
                                  child: Center(
                                      child: Text(
                                    "${walletdetails["Amount"]}",
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                )),
                                Expanded(
                                    child: Container(
                                  child: Center(
                                      child: Text(
                                    "${walletdetails["Amount"] - walletdetails["Fare"]}",
                                    style: const TextStyle(fontSize: 15),
                                  )),
                                ))
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
      drawer:
          CustomerHomeDrawer(username: widget.username, userid: widget.userid),
    );
  }
}
