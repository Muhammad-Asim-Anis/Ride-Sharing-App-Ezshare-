// ignore_for_file: avoid_unnecessary_containers
import 'dart:convert';

import 'package:ezshare/Customerscreens/screens/customercanceltrip.dart';
import 'package:ezshare/Riderscreens/screens/riderridecompletefeedback.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Providers/messageprovider.dart';
import 'package:http/http.dart' as http;

class CustomerBookCard extends StatefulWidget {
  final String customername;
  final String vehiclemodel;
  final String vehiclename;
  final String vehicle;
  final int seats;
  final String time;
  final String date;
  final String startingpoint;
  final String endpoint;
  final String senderid;
  final String receiveid;
  final String imageurl;
  final String usercontact;
  final String rideid;
  final String ridername;
  final bool afterstart;
  final bool ridestart;
  final List<Location> sourcelist;
  final List<Location> destinationlist;
  final int userlength;
  final double distance;
  final int usertime;
  final double fare;
  const CustomerBookCard(
      {super.key,
      required this.customername,
      required this.vehiclemodel,
      required this.seats,
      required this.time,
      required this.date,
      required this.startingpoint,
      required this.endpoint,
      required this.senderid,
      required this.receiveid,
      required this.imageurl,
      required this.usercontact,
      required this.rideid,
      required this.afterstart,
      required this.ridername,
      required this.ridestart,
      required this.sourcelist,
      required this.destinationlist,
      required this.userlength,
      required this.distance,
      required this.usertime,
      required this.vehiclename,
      required this.fare,
      required this.vehicle});

  @override
  State<CustomerBookCard> createState() => _CustomerBookCardState();
}

class _CustomerBookCardState extends State<CustomerBookCard> {
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
  CollectionReference chats = FirebaseFirestore.instance.collection("Chats");
  String roomid = "";
  bool isarrived = false, isstart = false;
  bool isaccept = false;
  double latitude = 0.0, longitude = 0.0, distance = 0.0, fare = 0.0;
  String useraddress = "", startdate = "";
  int time = 0;
  @override
  void initState() {
    super.initState();
    ridearrivedcheck();
    ridestartcheck();
    rideaccpetcheck(); 
  }

  createchatroom() async {
    QuerySnapshot snapshot = await chats
        .where("participants.${widget.senderid}", isEqualTo: true)
        .where("participants.${widget.receiveid}", isEqualTo: true)
        .get();
    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        roomid = element.id;
      }
    } else {
      await chats.doc("${widget.senderid}${widget.receiveid}").set({
        "Senderid": widget.senderid,
        "Reciverid": widget.receiveid,
        "participants": {widget.senderid: true, widget.receiveid: true}
      });
      roomid = "${widget.senderid}${widget.receiveid}";
    }
  }

  ridearrivedcheck() {
    rides.doc(widget.rideid).snapshots().listen((event) {
      Map<String, dynamic> users = event["users"];
      setState(() {
        try {
          isarrived = users.entries
              .firstWhere((element) => element.key == widget.receiveid)
              .value["arrived"];
        } catch (e) {
          isarrived = false;
        }
      });
    });
  }

  ridestartcheck() {
    rides.doc(widget.rideid).snapshots().listen((event) {
      Map<String, dynamic> users = event["users"];
      setState(() {
        try {
          isstart = users.entries
              .firstWhere((element) => element.key == widget.receiveid)
              .value["start"];
        } catch (e) {
          isstart = false;
        }
      });
    });
  }

   rideaccpetcheck() {
    rides.doc(widget.rideid).snapshots().listen((event) {
      Map<String, dynamic> ridesaccpeted = event["Rideracceptedcustomer"];
      setState(() {
        try {
          isaccept = ridesaccpeted.containsKey(widget.receiveid);
             
        } catch (e) {
          isaccept = false;
        }
      });
    });
  }
  Future<Map<String, dynamic>> fetchRouteData(String apiKey, double startLat,
      double startLng, double endLat, double endLng) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$startLat,$startLng&destination=$endLat,$endLng&key=$apiKey";
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch route data');
    }
  }

  double getDistanceFromRoute(Map<String, dynamic> routeData) {
    double distanceInKilometers = 0.0;
    try {
      int distanceInMeters =
          routeData['routes'][0]['legs'][0]['distance']['value'];
      distanceInKilometers = distanceInMeters / 1000;
    } catch (e) {
      print(e);
    }
    return distanceInKilometers;
  }

  int getTimeFromRoute(Map<String, dynamic> routeData) {
    int timeInSeconds = 0;
    try {
      timeInSeconds = routeData['routes'][0]['legs'][0]['duration']['value'];
    } catch (e) {
      print(e);
    }

    return timeInSeconds;
  }

  loaddata() async {
    await getusercurrentposition().then((value) async {
      latitude = value.latitude;
      longitude = value.longitude;

      var addresses = await placemarkFromCoordinates(latitude, longitude);

      var first = addresses.first;
      var last = addresses.last;

      useraddress = "${first.name} ${last.street}";
      List<Location> locationsstartuser =
          await locationFromAddress(widget.startingpoint.toString());

      Map<String, dynamic> routeData = await fetchRouteData(
          "AIzaSyCPVtwUwZEhuK351SVc9sZ_cwGYOOvcJJk",
          locationsstartuser.first.latitude,
          locationsstartuser.first.longitude,
          latitude,
          longitude);

      distance = getDistanceFromRoute(routeData).ceilToDouble();
      time = (getTimeFromRoute(routeData) / 60).round();

      if (distance > widget.distance) {
        fare = ((widget.vehiclename == "Bike")
            ? distance * 15 * widget.seats
            : (widget.vehiclename == "Car")
                ? distance * 25 * widget.seats
                : (widget.vehiclename == "Suv")
                    ? distance * 40 * widget.seats
                    : distance * 0 * widget.seats);
      } else {
        fare = widget.fare;
      }
    });
  }

  Future<Position> getusercurrentposition() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    final messageprovider = Provider.of<MessageCardProvider>(context);
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
                        widget.customername,
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
                            onTap: () async {
                              await createchatroom();

                              messageprovider.setRoomId(roomid);

                              messageprovider.setItemCount(1);
                              messageprovider.setClick();
                            },
                            child: Container(
                                width: 39,
                                height: 30,
                                decoration: BoxDecoration(
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
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () async {
                              Uri phoneno =
                                  Uri.parse("tel:${widget.usercontact}");
                              await launchUrl(phoneno);
                            },
                            child: Container(
                                width: 39,
                                height: 30,
                                decoration: BoxDecoration(
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
                      width: 200,
                      height: 10,
                      margin: const EdgeInsets.only(bottom: 0),
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
                        "Customer Drop-Off Location",
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
            margin: const EdgeInsets.only(left: 25, top: 10, right: 20),
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
          (widget.afterstart == false)
              ? Row(
                  mainAxisAlignment: (isstart)
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceAround,
                  children: [
                    (isarrived == false && isstart == false)
                        ? Container(
                            height: 33,
                            width: 106,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.blue,
                            ),
                            child: InkWell(
                              onTap: () {
                                rides.doc(widget.rideid).update({
                                  "users.${widget.receiveid}.arrived": true,
                                });
                              },
                              child: Center(
                                child: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Arrived",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                          )
                        : (isstart == false)
                            ? Container(
                                height: 33,
                                width: 106,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.blue,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    rides.doc(widget.rideid).update({
                                      "users.${widget.receiveid}.start": true,
                                    });
                                    setState(() {
                                      startdate = DateTime.now().toString();
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Start",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ),
                              )
                            : Container(
                                height: 33,
                                width: 106,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.blue,
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    await loaddata();
                                    // await rides.doc(widget.rideid).update({
                                    //   "users.${widget.receiveid}.end": true,
                                    // });

                                    // ignore: use_build_context_synchronously
                                    await Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType
                                                .leftToRightWithFade,
                                            child:
                                                RiderRideCompleteFeedbackScreen(
                                              seats: widget.seats,
                                              vehicle: widget.vehiclename,
                                              numberPlate: widget.vehiclemodel,
                                              vehicleName: widget.vehicle,
                                              startdate: startdate,
                                              time: time,
                                              distance: widget.distance,
                                              cardid: widget.rideid,
                                              customername: widget.customername,
                                              destinationlist:
                                                  widget.destinationlist,
                                              endpoint: widget.endpoint,
                                              fare: fare.toInt(),
                                              imageurl: widget.imageurl,
                                              ridername: widget.ridername,
                                              sourcelist: widget.sourcelist,
                                              startingpoint:
                                                  widget.startingpoint,
                                              userid: widget.receiveid,
                                              userlength: widget.userlength,
                                              riderid: widget.senderid,
                                            )));
                                  },
                                  child: Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "End",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ),
                              ),
                    (isstart == false)
                        ? Container(
                            height: 33,
                            width: 106,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.blue,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CustomerCancelTripScreen(
                                        destinationlist: widget.destinationlist,
                                        sourcelist: widget.sourcelist,
                                        userlength: widget.userlength,
                                        arrived: isarrived,
                                        ridestart: widget.ridestart,
                                        date: widget.date,
                                        endpoint: widget.endpoint,
                                        imageurl: widget.imageurl,
                                        rideid: widget.rideid,
                                        riderid: widget.senderid,
                                        ridername: widget.ridername,
                                        seats: widget.seats,
                                        startingpoint: widget.startingpoint,
                                        time: widget.time,
                                        userid: widget.receiveid,
                                        username: widget.customername,
                                        vehiclemodel: widget.vehiclemodel,
                                      ),
                                    ));
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
                          )
                        : Container(),
                  ],
                )
              : (isaccept == false)
                  ? Row(
                      mainAxisAlignment: (isstart)
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 33,
                          width: 106,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.blue,
                          ),
                          child: InkWell(
                            onTap: () async {
                              await rides.doc(widget.rideid).update({
                                "Rideracceptedcustomer": {
                                  widget.receiveid: true
                                }
                              });
                              setState(() {
                                isaccept = true;
                              });
                            },
                            child: Center(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Accept",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ),
                        ),
                        Container(
                          height: 33,
                          width: 106,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.blue,
                          ),
                          child: InkWell(
                            onTap: () async {
                              await rides.doc(widget.rideid).update({
                                "users.${widget.receiveid}": FieldValue.delete()
                              });
                            },
                            child: Center(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Reject",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: (isstart)
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceAround,
                      children: [
                        (isarrived == false)
                            ? Container(
                                height: 33,
                                width: 106,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.blue,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    rides.doc(widget.rideid).update({
                                      "users.${widget.receiveid}.arrived": true,
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Arrived",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ),
                              )
                            : (isstart == false)
                                ? Container(
                                    height: 33,
                                    width: 106,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.blue,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        rides.doc(widget.rideid).update({
                                          "users.${widget.receiveid}.start":
                                              true,
                                        });
                                      },
                                      child: Center(
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "Start",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 33,
                                    width: 106,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.blue,
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        await loaddata();
                                        // await rides.doc(widget.rideid).update({
                                        //   "users.${widget.receiveid}.end": true,
                                        // });

                                        // ignore: use_build_context_synchronously
                                        await Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .leftToRightWithFade,
                                                child:
                                                    RiderRideCompleteFeedbackScreen(
                                                  seats: widget.seats,
                                                  vehicle: widget.vehiclename,
                                                  numberPlate:
                                                      widget.vehiclemodel,
                                                  vehicleName: widget.vehicle,
                                                  startdate: startdate,
                                                  time: time,
                                                  distance: widget.distance,
                                                  cardid: widget.rideid,
                                                  customername:
                                                      widget.customername,
                                                  destinationlist:
                                                      widget.destinationlist,
                                                  endpoint: widget.endpoint,
                                                  fare: fare.toInt(),
                                                  imageurl: widget.imageurl,
                                                  ridername: widget.ridername,
                                                  sourcelist: widget.sourcelist,
                                                  startingpoint:
                                                      widget.startingpoint,
                                                  userid: widget.receiveid,
                                                  userlength: widget.userlength,
                                                  riderid: widget.senderid,
                                                )));
                                      },
                                      child: Center(
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "End",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ),
                        (isstart == false)
                            ? Container(
                                height: 33,
                                width: 106,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.blue,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CustomerCancelTripScreen(
                                            destinationlist:
                                                widget.destinationlist,
                                            sourcelist: widget.sourcelist,
                                            userlength: widget.userlength,
                                            arrived: isarrived,
                                            ridestart: widget.ridestart,
                                            date: widget.date,
                                            endpoint: widget.endpoint,
                                            imageurl: widget.imageurl,
                                            rideid: widget.rideid,
                                            riderid: widget.senderid,
                                            ridername: widget.ridername,
                                            seats: widget.seats,
                                            startingpoint: widget.startingpoint,
                                            time: widget.time,
                                            userid: widget.receiveid,
                                            username: widget.customername,
                                            vehiclemodel: widget.vehiclemodel,
                                          ),
                                        ));
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
                              )
                            : Container(),
                      ],
                    )
        ],
      ),
    );
  }
}
