// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                  child: const Text(
                    "Balance Rs: 3",
                    style: TextStyle(
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
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                  )),
                  Expanded(
                      child: Container(
                    child: const Center(
                        child: Text(
                      "Fare",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                  )),
                  Expanded(
                      child: Container(
                    child: const Center(
                        child: Text(
                      "Amount",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                  )),
                  Expanded(
                      child: Container(
                    child: const Center(
                        child: Text(
                      "Balance",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                  ))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    child: const Center(
                        child: Text(
                      "Jan 12,12:24 \n Top up",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
                  )),
                  Expanded(
                      child: Container(
                    child: const Center(
                        child: Text(
                      "157",
                      style: TextStyle(fontSize: 15),
                    )),
                  )),
                  Expanded(
                      child: Container(
                    child: const Center(
                        child: Text(
                      "160",
                      style: TextStyle(fontSize: 15),
                    )),
                  )),
                  Expanded(
                      child: Container(
                    child: const Center(
                        child: Text(
                      "3",
                      style: TextStyle(fontSize: 15),
                    )),
                  ))
                ],
              ),
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
                      "Jan 12,12:24 \n Top up",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
                  )),
                  Expanded(
                      child: Container(
                    child: const Center(
                        child: Text(
                      "157",
                      style: TextStyle(fontSize: 15),
                    )),
                  )),
                  Expanded(
                      child: Container(
                    child: const Center(
                        child: Text(
                      "160",
                      style: TextStyle(fontSize: 15),
                    )),
                  )),
                  Expanded(
                      child: Container(
                    child: const Center(
                        child: Text(
                      "3",
                      style: TextStyle(fontSize: 15),
                    )),
                  ))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    child: const Center(
                        child: Text(
                      "Jan 12,12:24 \n Top up",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
                  )),
                  Expanded(
                      child: Container(
                    child: const Center(
                        child: Text(
                      "157",
                      style: TextStyle(fontSize: 15),
                    )),
                  )),
                  Expanded(
                      child: Container(
                    child: const Center(
                        child: Text(
                      "160",
                      style: TextStyle(fontSize: 15),
                    )),
                  )),
                  Expanded(
                      child: Container(
                    child: const Center(
                        child: Text(
                      "3",
                      style: TextStyle(fontSize: 15),
                    )),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
