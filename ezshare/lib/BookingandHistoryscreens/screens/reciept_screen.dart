// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class RecieptScreen extends StatefulWidget {
  const RecieptScreen({super.key});

  @override
  State<RecieptScreen> createState() => _RecieptScreenState();
}

class _RecieptScreenState extends State<RecieptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Jan 12, 12:24 PM",
          style: TextStyle(
              color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 189, 189, 189),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 50, top: 15, bottom: 15),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Expanded(
                            flex: 2,
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 25,
                            )),
                        Expanded(
                            flex: 8,
                            child: Text(
                              "Sadar,Karachi",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                            flex: 2,
                            child: Icon(
                              Icons.arrow_circle_down,
                              color: Colors.black,
                              size: 12,
                            )),
                        Expanded(
                          flex: 8,
                          child: Container(),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                            flex: 2,
                            child: Icon(
                              Icons.arrow_circle_down,
                              color: Colors.black,
                              size: 12,
                            )),
                        Expanded(
                          flex: 8,
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                            flex: 2,
                            child: Icon(
                              Icons.arrow_circle_down,
                              color: Colors.black,
                              size: 12,
                            )),
                        Expanded(
                          flex: 8,
                          child: Container(),
                        )
                      ],
                    ),
                    Row(
                      children: const [
                        Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.location_on,
                            size: 25,
                            color: Colors.blue,
                          ),
                        ),
                        Expanded(
                            flex: 8,
                            child: Text(
                              "Hussainabad,Karachi",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Base fare",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "15",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Distance(10 KM)",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "150",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Waiting time(6 min)",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "12",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Fare",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "177",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Total fare of Seats(2)",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "334",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Wallet deduction",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "-10",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 1,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Total Fare",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "324",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 1,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Driver Name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Ahsan",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Vehicle",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Honda",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Number plate",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "KMI-452",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text("Report problem"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
