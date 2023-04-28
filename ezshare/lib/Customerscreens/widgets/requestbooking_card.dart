// ignore_for_file: avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Providers/googlemapprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../Providers/messageprovider.dart';
import '../../Riderscreens/screens/custommarker.dart';

class CustomerRequestBookingCard extends StatefulWidget {
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
  const CustomerRequestBookingCard(
      {super.key,
      required this.userid,
      required this.username,
      required this.ridername,
      required this.vehiclemodel,
      required this.seats,
      required this.time,
      required this.date,
      required this.startingpoint,
      required this.endpoint,
      required this.vehicleplatenumber,
      required this.rideid});

  @override
  State<CustomerRequestBookingCard> createState() =>
      _CustomerRequestBookingCardState();
}

class _CustomerRequestBookingCardState
    extends State<CustomerRequestBookingCard> {
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
  int count = 1;
  int avaliableseats = 0;

  @override
  initState() {
    super.initState();
    ridedataretrive();
  }

  ridedataretrive() async {
    await rides.doc(widget.rideid).snapshots().forEach((element) {
      List array = element["users"];
      setState(() {
        avaliableseats = widget.seats - array.length;
      });
      if (avaliableseats == 0) {
        count = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messageprovider = Provider.of<MessageCardProvider>(context);
    final googlemapprovider = Provider.of<GoogleMapProvider>(context);
    return Container(
      margin: const EdgeInsets.all(15),
      width: 300,
      height: 450,
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
            height: 100,
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
                    height: 57,
                    width: 69,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc=",
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 0, top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                  child: Text(
                                widget.ridername,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              )),
                              Container(
                                  child: Text(
                                widget.vehiclemodel,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500),
                              )),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Container(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    messageprovider.setClick();
                                  },
                                  child: Container(
                                      width: 39,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          boxShadow: const [
                                            BoxShadow(
                                              color:
                                                  Color.fromARGB(50, 0, 0, 0),
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
                                const SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    ridedataretrive();
                                  },
                                  child: Container(
                                      width: 39,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          boxShadow: const [
                                            BoxShadow(
                                              color:
                                                  Color.fromARGB(50, 0, 0, 0),
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
                            ),
                          ),
                        ],
                      ),
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
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Row(
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
                      Container(
                        margin: const EdgeInsets.only(top: 0, bottom: 2),
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
                      Container(
                        margin: const EdgeInsets.only(top: 0, bottom: 2),
                        child: const Text(
                          "Ending point",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 10,
                        margin: const EdgeInsets.only(bottom: 0),
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
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10),
            child: SizedBox(
              height: 1.0,
              child: Container(
                margin: const EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                height: 1.0,
                width: 300,
                color: Colors.blue,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 280,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 0, bottom: 2),
                                child: const Text(
                                  "Your Pick-up Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 7),
                                child: const Text(
                                  "Saddar,Karachi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              if (!googlemapprovider.pickup) {
                                googlemapprovider.markers.add(Marker(
                                    icon: BitmapDescriptor.defaultMarker,
                                    markerId: const MarkerId("4"),
                                    position: googlemapprovider.position,
                                    infoWindow: const InfoWindow(
                                        title: "Customer Source Location")));
                                googlemapprovider.setpickup();
                              } else {
                               googlemapprovider.markers.removeWhere((element) => element.markerId.value == '4',);
                                googlemapprovider.unsetpickup();
                              }
                            },
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                  color: (googlemapprovider.pickup)
                                      ? Colors.redAccent
                                      : Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Icon(
                                (googlemapprovider.pickup)
                                    ? Icons.close
                                    : Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      child: SizedBox(
                        height: 1.0,
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(
                              start: 1.0, end: 1.0),
                          height: 1.0,
                          width: 279,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 280,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 0, bottom: 2),
                                child: const Text(
                                  "YourDrop-Off Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                              Container(
                                child: const Text(
                                  "Hussainabad,Karachi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                               

                              if (!googlemapprovider.dropoff) {
                                   googlemapprovider.markers.add(Marker(
                                    icon: BitmapDescriptor.defaultMarker,
                                    markerId: const MarkerId("5"),
                                    position: googlemapprovider.position,
                                    infoWindow: const InfoWindow(
                                        title: "Customer Destination Location")));
                                googlemapprovider.setdropoff();
                              } else {
                                  googlemapprovider.markers.removeWhere((element) => element.markerId.value == '5',);
                                googlemapprovider.unsetdropoff();
                              }
                            },
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                  color: (googlemapprovider.dropoff)
                                      ? Colors.redAccent
                                      : Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Icon(
                                (googlemapprovider.dropoff)
                                    ? Icons.close
                                    : Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10),
            child: SizedBox(
              height: 1.0,
              child: Container(
                margin: const EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                height: 1.0,
                width: 300,
                color: Colors.blue,
              ),
            ),
          ),
          Container(
            width: 286,
            margin: const EdgeInsets.only(left: 0, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Seat Capacity",
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                  ),
                ),
                Text("${widget.seats}",
                    style: GoogleFonts.poppins(
                      fontSize: 9,
                    ))
              ],
            ),
          ),
          Container(
            width: 286,
            margin: const EdgeInsets.only(left: 0, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Plate-Number",
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                  ),
                ),
                Text(widget.vehicleplatenumber.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 9,
                    ))
              ],
            ),
          ),
          Container(
            width: 286,
            margin: const EdgeInsets.only(left: 0, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Available Seat",
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                  ),
                ),
                Text("$avaliableseats",
                    style: GoogleFonts.poppins(
                      fontSize: 9,
                    ))
              ],
            ),
          ),
          Container(
            width: 286,
            margin: const EdgeInsets.only(left: 0, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Seat Booking",
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 155, 155, 155),
                                border: Border.all(color: Colors.grey),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomLeft: Radius.circular(4))),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (count >= 1 && count < avaliableseats) {
                                    count++;
                                  }
                                });
                              },
                              child: const Icon(
                                Icons.add,
                                size: 20,
                              ),
                            ),
                          ),
                          Container(
                            height: 22,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 155, 155, 155))),
                            child: Center(
                              child: Text("$count",
                                  style: GoogleFonts.poppins(fontSize: 12),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 155, 155, 155),
                                border: Border.all(color: Colors.grey),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    bottomRight: Radius.circular(4))),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (count > 1) {
                                    count--;
                                  }
                                });
                              },
                              child: const Icon(
                                CupertinoIcons.minus,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 35,
              width: 285,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: (avaliableseats != 0) ? Colors.blue : Colors.grey,
              ),
              child: InkWell(
                onTap: () {
                  //  Navigator.push(
                  // context,
                  // MaterialPageRoute(
                  //   builder: (context) => const  RiderRideDetailViewScreen(userid: '', username: '',),
                  // ));
                },
                child: Center(
                  child: Container(
                      alignment: Alignment.center,
                      child: (avaliableseats != 0)
                          ? const Text(
                              "Request Booking",
                              style: TextStyle(color: Colors.white),
                            )
                          : const Text(
                              "No Seats Avaliable",
                              style: TextStyle(color: Colors.white),
                            )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
