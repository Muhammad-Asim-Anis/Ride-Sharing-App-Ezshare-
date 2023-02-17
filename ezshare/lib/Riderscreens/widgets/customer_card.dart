// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerBookCard extends StatefulWidget {
  final String customername;
  final String vehiclemodel;
  final int seats;
  final String time;
  final String date;
  final String startingpoint;
  final String endpoint;
  const CustomerBookCard(
      {super.key,
      required this.customername,
      required this.vehiclemodel,
      required this.seats,
      required this.time,
      required this.date,
      required this.startingpoint,
      required this.endpoint});

  @override
  State<CustomerBookCard> createState() => _CustomerBookCardState();
}

class _CustomerBookCardState extends State<CustomerBookCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: 300,
      height: 300,
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
        children: [
          Container(
            height: 79,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7), topRight: Radius.circular(7)),
                color: Colors.blue),
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.all(0),
                    height: 50,
                    width: 47,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc=",
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                        "Customer Name",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      )),
                      const SizedBox(
                        height: 0,
                      ),
                      Container(
                          child: Row(
                        children: [
                          Text(
                            "Time: ${widget.time}",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          InkWell(
                            onTap: () {
                              
                            },
                            child: Container(
                              width: 39,
                              height: 30,
                                decoration:  BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromARGB(50, 0, 0, 0),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      )
                                    ]),
                                child: const Icon(
                                  Icons.message_rounded,
                                  color: Colors.white,
                                  size: 20,
                                )),
                          ),
                          const SizedBox(width: 20,),
                          InkWell(
                            onTap: () {
                              
                            },
                            child: Container(
                              width: 39,
                              height: 30,
                                decoration:  BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromARGB(50, 0, 0, 0),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      )
                                    ]),
                                child: const Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 20,
                                )),
                          )

                        ],
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 2),
                      child: const Text(
                        "Customer Pick-up Location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      child: const Text(
                        "Saddar,Karachi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                      child: Center(
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(
                              start: 1.0, end: 1.0),
                          height: 1.0,
                          width: 230,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 2),
                      child: const Text(
                        "Customer Drop-Off Location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
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
          Container(
            margin: const EdgeInsets.only(left: 25, top: 10),
            child: SizedBox(
              height: 1.0,
              child: Container(
                margin: const EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                height: 1.0,
                width: 270,
                color: Colors.blue,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 25, top: 10,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Seat Booked: ",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                  ),
                ),
                Text(
                  "1",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                  ),
                ),
                
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 33,
                  width: 106,
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
                            "Start",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ),
              ),
              
            ],
          )
        ],
      ),
    );
  }
}
