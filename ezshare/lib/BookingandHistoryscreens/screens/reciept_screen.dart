// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecieptScreen extends StatefulWidget {
  final String startdate;
  final String userstartlocation;
  final String userendlocation;
  final int cost;
  final String vehicletype;
  final String vehicleName;
  final String drivername;
  final String numberplate;
  final double distance;
  final int seats;
  final int walletdeduction; 
  const RecieptScreen({super.key, required this.startdate, required this.userstartlocation, required this.userendlocation, required this.cost, required this.vehicletype, required this.vehicleName, required this.drivername, required this.numberplate, required this.distance, required this.seats, required this.walletdeduction});

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
        leading: SizedBox(
            width: 10,
            height: 10,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  CupertinoIcons.back,
                  size: 30,
                  color: Colors.blueAccent,
                ))),
        title:  Text(
         widget.startdate,
          style: const TextStyle(
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
                      children:  [
                        const Expanded(
                            flex: 2,
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 25,
                            )),
                        Expanded(
                            flex: 8,
                            child: Text(
                              widget.userstartlocation,
                              style: const TextStyle(
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
                      children:  [
                        const Expanded(
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
                              widget.userendlocation,
                              style: const TextStyle(
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
                      children:  [
                        const Text(
                          "Base fare",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          (widget.vehicletype == "Bike")? "15" : (widget.vehicletype == "Car") ? "25" : (widget.vehicletype == "Suv") ? "40" : "0",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text(
                          "Distance(${widget.distance.toInt()} KM)",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.cost}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const Text(
                          "Fare",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                         "${widget.cost}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text(
                          "Total fare of Seats(${widget.seats})",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.seats * widget.cost}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const Text(
                          "Wallet deduction",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.walletdeduction}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
                      children:  [
                         const Text(
                          "Total Fare",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.cost - widget.walletdeduction}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
                      children:  [
                       const Text(
                          "Driver Name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                         widget.drivername,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const Text(
                          "Vehicle",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                         widget.vehicleName,
                          style:const  TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const Text(
                          "Number plate",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                         widget.numberplate,
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
