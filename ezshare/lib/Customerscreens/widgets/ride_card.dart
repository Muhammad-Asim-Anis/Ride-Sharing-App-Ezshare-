// ignore_for_file: camel_case_types, avoid_unnecessary_containers

import 'package:flutter/material.dart';


class rideCard extends StatefulWidget {
  final String ridername;
  final String vehiclemodel;
  final int seats;
  final String time;
  final String date;
  final String startingpoint;
  final String endpoint; 
  const rideCard({super.key, required this.ridername, required this.vehiclemodel, required this.seats, required this.time, required this.date, required this.startingpoint, required this.endpoint});

  @override
  State<rideCard> createState() => _rideCardState();
}

class _rideCardState extends State<rideCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 270,
        height: 230,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
                spreadRadius: .5,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                  // decoration:
                  //     BoxDecoration(color: Color.fromARGB(255, 187, 97, 90)),
                  child: Row(
                    children: [
                      Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc=",
                            ),
                          )),
                      SizedBox(
                          width: 170,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.zero,
                                child: Column(children:  [
                                  const SizedBox(height: 8),
                                  Text(widget.ridername,
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    widget.vehiclemodel,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text("${widget.seats} Seats",
                                      style: const TextStyle(
                                        color: Colors.blue,
                                      )),
                                ]),
                              ),
                              Container(
                                child: Column(children:  [
                                  const SizedBox(height: 8),
                                 const Text("(4.5)",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      )),
                                  const Text(
                                    "Rating",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 8),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Time: ${widget.time}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                  Text(
                                    "Date: ${widget.date}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                ]),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: 280,
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: const Text(
                      "Location:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 17,
                            ),
                            Icon(
                              Icons.arrow_circle_down,
                              size: 10,
                            ),
                            Icon(
                              Icons.arrow_circle_down,
                              size: 10,
                            ),
                            Icon(
                              Icons.arrow_circle_down,
                              size: 10,
                            ),
                            Icon(
                              Icons.location_on,
                              size: 17,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Starting point",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            const Text(
                              "Saddar,Karachi",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.grey),
                            ),
                            SizedBox(
                              height: 10.0,
                              child:  Center(
                                child:  Container(
                                  margin:  const EdgeInsetsDirectional.only(
                                      start: 1.0, end: 1.0),
                                  height: 1.0,
                                  width: 230,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            const Text(
                              "Ending point",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            const Text(
                              "Hussainabad,Karachi",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            height: 25,
                            width: 240,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.blue,
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                child: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Book now",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                          ),
                        )
                      ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
