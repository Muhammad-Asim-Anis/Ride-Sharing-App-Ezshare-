// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class InProgressRideCard extends StatefulWidget {
  final String userid;
  final String username;
  final String ridername;
  final String vehiclemodel;
  final String vehicleplatenumber;
  final int seats;
  final String time;
  final String date;
  final String startingpoint;
  final String endpoint;
  final String rideid;
  final String imageurl;
  final Map<String, dynamic> usersdata;
  final String vehiclename;
  final String riderid;
  const InProgressRideCard({super.key, required this.userid, required this.username, required this.ridername, required this.vehiclemodel, required this.vehicleplatenumber, required this.seats, required this.time, required this.date, required this.startingpoint, required this.endpoint, required this.rideid, required this.imageurl, required this.usersdata, required this.vehiclename, required this.riderid});

  @override
  State<InProgressRideCard> createState() => _InProgressRideCardState();
}

class _InProgressRideCardState extends State<InProgressRideCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140, width: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 206, 206, 206),
              blurRadius: 5.0,
              spreadRadius: .1,
            )
          ]),
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  children: const [
                    SizedBox(
                      height: 13,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.red,
                      size: 25,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Icon(
                      Icons.arrow_circle_down,
                      size: 15,
                    ),
                    Icon(
                      Icons.arrow_circle_down,
                      size: 15,
                    ),
                    Icon(
                      Icons.arrow_circle_down,
                      size: 15,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Icon(
                      Icons.location_on,
                      size: 25,
                      color: Colors.blue,
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      "${widget.date}, ${widget.time}",
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    SizedBox(
                      width: 250,
                      height: 20,
                      child: Text(
                        widget.startingpoint,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.blue),
                      ),
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    SizedBox(
                      width: 200,
                      height: 20,
                      child: Text(
                        widget.endpoint,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 13,
                      ),
                      Text(
                        "In-Progress",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ))),
         
        ],
      ),
    );
  }
}
