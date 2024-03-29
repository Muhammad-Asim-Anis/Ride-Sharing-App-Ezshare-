// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class HistoryCard extends StatefulWidget {
  final String startdate;
  final String userstartlocation;
  final String userendlocation;
  final String endtime;
  final int totaltime;
  final int cost; 

  const HistoryCard({super.key, required this.startdate, required this.userstartlocation, required this.userendlocation, required this.endtime, required this.totaltime, required this.cost});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
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
                  children:  [
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      widget.startdate,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    SizedBox(
                      width: 200,
                      height: 20,
                      child: Text(
                       widget.userstartlocation,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.blue),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 200,
                      height: 20,
                      child: Text(
                        widget.endtime,
                        style:
                            const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                    Text(
                     widget.userendlocation,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.blue),
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
                        "Completed",
                        style: TextStyle(
                            color: Color.fromARGB(255, 41, 143, 45),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ))),
          Expanded(
              flex: 2,
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: const Color.fromARGB(255, 92, 92, 92),
                    height: 110,
                    width: 0.3,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                     const Text(
                        "Travel Time",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        "${widget.totaltime} Min",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      const Text(
                        "Travel Cost",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Rs: ${widget.cost}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ))),
        ],
      ),
    );
  }
}
