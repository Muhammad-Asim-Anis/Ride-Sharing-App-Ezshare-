// ignore_for_file: avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Riderscreens/screens/riderridedetailview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderCard extends StatefulWidget {
  final String userid;
  final String username;
  final String ridername;
  final String vehiclemodel;
  final int seats;
  final String time;
  final String date;
  final String startingpoint;
  final String endpoint;
  final String cardid;
  final Map<String, dynamic> usersData;
  final String imageurl;
  const RiderCard(
      {super.key,
      required this.ridername,
      required this.vehiclemodel,
      required this.seats,
      required this.time,
      required this.date,
      required this.startingpoint,
      required this.endpoint,
      required this.userid,
      required this.username,
      required this.cardid,
      required this.usersData,
      required this.imageurl});

  @override
  State<RiderCard> createState() => _RiderCardState();
}

class _RiderCardState extends State<RiderCard> {
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
  @override
  Widget build(BuildContext context) {
    // print(widget.imageurl);
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
            padding: const EdgeInsets.all(0),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(0),
                  height: 50,
                  width: 47,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: (widget.imageurl.isNotEmpty)
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                            widget.imageurl,
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(
                            CupertinoIcons.person_circle,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                        widget.ridername,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      )),
                      const SizedBox(
                        height: 3,
                      ),
                      Container(
                          child: Row(
                        children: [
                          Text(
                            "Date: ${widget.date}",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Time: ${widget.time}",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
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
                        "Starting point",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 10,
                      margin: const EdgeInsets.only(bottom: 7),
                      child: Text(
                        widget.startingpoint,
                        style: const TextStyle(
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
                        "Ending point",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 10,
                      margin: const EdgeInsets.only(bottom: 7),
                      child: Text(
                        widget.endpoint,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.grey),
                      ),
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
            margin: const EdgeInsets.only(left: 0, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Seat Avaliable: ${widget.seats - widget.usersData.length}",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                  ),
                ),
                Text("Seat Booked:  ${widget.usersData.length}",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                    ))
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
                    onTap: () async {
                      List<Location> locationssource =
                          await locationFromAddress(
                              widget.startingpoint.toString());

                      List<Location> locationsdestination =
                          await locationFromAddress(widget.endpoint.toString());
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RiderRideDetailViewScreen(
                              userid: widget.userid,
                              username: widget.username,
                              cardid: widget.cardid,
                              destinationlist: locationsdestination,
                              sourcelist: locationssource,
                              userlength: widget.usersData.length,
                            ),
                          ));
                    },
                    child: Center(
                      child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "View",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Center(
                child: Container(
                  height: 33,
                  width: 106,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.blue,
                  ),
                  child: InkWell(
                    onTap: () async {
                      await rides.doc(widget.cardid).delete();
                    },
                    child: Center(
                      child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "Cencel",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
