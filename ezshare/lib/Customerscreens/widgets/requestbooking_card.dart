// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Customerscreens/screens/customerbookingstart.dart';
import 'package:ezshare/Providers/googlemapprovider.dart';
import 'package:ezshare/Providers/ridestartprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../Providers/messageprovider.dart';
import '../../Riderscreens/screens/custommarker.dart';
import '../../successlogin.dart';
import 'package:ezshare/Customerscreens/screens/dynamicridesdetail.dart';

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
  final String imageurl;
  final String vehiclename;
  final Map<String, dynamic> userdata;
  final String riderid;
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
      required this.rideid,
      required this.imageurl,
      required this.vehiclename,
      required this.userdata,
      required this.riderid});

  @override
  State<CustomerRequestBookingCard> createState() =>
      _CustomerRequestBookingCardState();
}

class _CustomerRequestBookingCardState
    extends State<CustomerRequestBookingCard> {
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  int count = 1;
  int avaliableseats = 0;
  Uint8List? usermarkerstartimage, usermarkerendimage;
  @override
  initState() {
    super.initState();
    ridedataretrive();
  }

  ridedataretrive() async {
    rides.doc(widget.rideid).snapshots().listen((element) {
      Map array = element["users"];
      setState(() {
        avaliableseats = widget.seats - array.length;
      });
      if (avaliableseats == 0) {
        count = 0;
      }
      if (avaliableseats > 0) {
        setState(() {
          count = 1;
        });
      }
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
    int distanceInMeters =
        routeData['routes'][0]['legs'][0]['distance']['value'];
    double distanceInKilometers = distanceInMeters / 1000;
    return distanceInKilometers;
  }

  int getTimeFromRoute(Map<String, dynamic> routeData) {
    int timeInSeconds = routeData['routes'][0]['legs'][0]['duration']['value'];
    return timeInSeconds;
  }

  @override
  Widget build(BuildContext context) {
    final messageprovider = Provider.of<MessageCardProvider>(context);
    final googlemapprovider = Provider.of<GoogleMapProvider>(context);
    final ridestartprovider = Provider.of<RideStartProvider>(context);
    return Container(
      margin: const EdgeInsets.all(15),
      width: 300,
      height: 500,
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
                              size: 70,
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
                                width: 220,
                                height: 10,
                                margin: const EdgeInsets.only(bottom: 7),
                                child: Text(
                                  googlemapprovider.startingaddress,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              await CustomMarkerMaker()
                                  .custommarkerfromasset(
                                      "assets/images/startingpointmarker.png",
                                      100,
                                      100)
                                  .then(
                                      (value) => usermarkerstartimage = value);
                              if (!googlemapprovider.pickup) {
                                googlemapprovider.markers.add(Marker(
                                    icon: BitmapDescriptor.fromBytes(
                                        usermarkerstartimage!),
                                    markerId: const MarkerId("4"),
                                    position: googlemapprovider.position,
                                    infoWindow: const InfoWindow(
                                        title: "Customer Source Location")));

                                var addresses = await placemarkFromCoordinates(
                                    googlemapprovider.position.latitude,
                                    googlemapprovider.position.longitude);
                                var first = addresses.first;
                                var last = addresses.last;

                                var useraddress =
                                    "${first.name} ${last.street}";
                                googlemapprovider
                                    .setStartingaddress(useraddress);
                                googlemapprovider.setpickup();
                              } else {
                                googlemapprovider.markers.removeWhere(
                                  (element) => element.markerId.value == '4',
                                );
                                googlemapprovider.unsetStartingaddress();
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
                                width: 220,
                                margin: const EdgeInsets.all(0),
                                height: 10,
                                child: Text(
                                  googlemapprovider.endaddress,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              double startpointlat = 0.0,
                                  startpointlong = 0.0,
                                  endpointlat = 0.0,
                                  endpointlong = 0.0;
                              await CustomMarkerMaker()
                                  .custommarkerfromasset(
                                      "assets/images/endpointmarker.png",
                                      100,
                                      100)
                                  .then((value) => usermarkerendimage = value);

                              if (!googlemapprovider.dropoff) {
                                googlemapprovider.markers.add(Marker(
                                    icon: BitmapDescriptor.fromBytes(
                                        usermarkerendimage!),
                                    markerId: const MarkerId("5"),
                                    position: googlemapprovider.position,
                                    infoWindow: const InfoWindow(
                                        title:
                                            "Customer Destination Location")));
                                var addresses = await placemarkFromCoordinates(
                                    googlemapprovider.position.latitude,
                                    googlemapprovider.position.longitude);
                                var first = addresses.first;
                                var last = addresses.last;

                                var useraddress =
                                    "${first.name} ${last.street}";
                                googlemapprovider.setEndaddress(useraddress);
                                googlemapprovider.setdropoff();

                                for (var element in googlemapprovider.markers) {
                                  if (element.markerId.value == "4") {
                                    startpointlat = element.position.latitude;
                                    startpointlong = element.position.longitude;
                                  }
                                  if (element.markerId.value == "5") {
                                    endpointlat = element.position.latitude;
                                    endpointlong = element.position.longitude;
                                  }
                                }

                                Map<String, dynamic> routeData =
                                    await fetchRouteData(
                                        "AIzaSyCPVtwUwZEhuK351SVc9sZ_cwGYOOvcJJk",
                                        startpointlat,
                                        startpointlong,
                                        endpointlat,
                                        endpointlong);
                                googlemapprovider.setDistance(
                                    getDistanceFromRoute(routeData));
                                googlemapprovider
                                    .setTime(getTimeFromRoute(routeData));
                              } else {
                                googlemapprovider.markers.removeWhere(
                                  (element) => element.markerId.value == '5',
                                );

                                googlemapprovider.unsetEndaddress();
                                googlemapprovider.unsetdropoff();
                                googlemapprovider.unsetDistance();
                                googlemapprovider.unsetTime();
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
          (googlemapprovider.distance != 0.0 && googlemapprovider.time != 0)
              ? Column(
                  children: [
                    Container(
                      width: 286,
                      margin: const EdgeInsets.only(left: 0, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Estimated Fare",
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                            ),
                          ),
                          Text(
                            "${(widget.vehiclename == "Bike") ? googlemapprovider.distance.ceilToDouble() * 15 * count : (widget.vehiclename == "Car") ? googlemapprovider.distance.ceilToDouble() * 25 * count : (widget.vehiclename == "Suv") ? googlemapprovider.distance.ceilToDouble() * 25 * count : googlemapprovider.distance.ceilToDouble() * 0 * count} Rs",
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                            ),
                          ),
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
                            "Estimated Time",
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                            ),
                          ),
                          Text(
                            "${(googlemapprovider.time / 60).round()} min",
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
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
            child: (avaliableseats != 0)
                ? Container(
                    height: 35,
                    width: 285,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: (avaliableseats != 0) ? Colors.blue : Colors.grey,
                    ),
                    child: InkWell(
                      onTap: () async {
                        Uint8List? markerstartimage, markerendimage;
                        CustomMarkerMaker()
                            .custommarkerfromasset(
                                "assets/images/Vector.png", 50, 50)
                            .then((value) => markerstartimage = value);
                        CustomMarkerMaker()
                            .custommarkerfromasset(
                                "assets/images/Vector-red.png", 50, 50)
                            .then((value) => markerendimage = value);
                        String imageurl = "";
                        await users.doc(widget.userid).get().then(
                          (value) {
                            try {
                              imageurl = value["imageurl"];
                            } catch (e) {
                              imageurl = "";
                            }
                          },
                        );
                        Map<String, dynamic> userdatabooked = {
                          widget.userid: {
                            "Estimated Fare": (widget.vehiclename == "Bike")
                                ? googlemapprovider.distance.ceilToDouble() *
                                    15 *
                                    count
                                : (widget.vehiclename == "Car")
                                    ? googlemapprovider.distance
                                            .ceilToDouble() *
                                        25 *
                                        count
                                    : (widget.vehiclename == "Suv")
                                        ? googlemapprovider.distance
                                                .ceilToDouble() *
                                            25 *
                                            count
                                        : googlemapprovider.distance
                                                .ceilToDouble() *
                                            0 *
                                            count,
                            "Estimated Time":
                                (googlemapprovider.time / 60).round(),
                            "Customer Number":
                                SuccessPage.user!.phoneNumber.toString(),
                            "Customer Name": widget.username,
                            "Customer Id": widget.userid,
                            "Seats booked": count,
                            "customerimageurl": imageurl,
                            "drop off": googlemapprovider.endaddress.toString(),
                            "pickup":
                                googlemapprovider.startingaddress.toString(),
                            "distance":
                                googlemapprovider.distance.ceilToDouble(),
                            "afterstart": (DynamicRidesDetailScreen.isridestart)
                                ? true
                                : false
                          }
                        };
                        Map<String, dynamic> userdata = {
                          "users": {
                            widget.userid: {
                              "Estimated Fare": (widget.vehiclename == "Bike")
                                  ? googlemapprovider.distance.ceilToDouble() *
                                      15 *
                                      count
                                  : (widget.vehiclename == "Car")
                                      ? googlemapprovider.distance
                                              .ceilToDouble() *
                                          25 *
                                          count
                                      : (widget.vehiclename == "Suv")
                                          ? googlemapprovider.distance
                                                  .ceilToDouble() *
                                              25 *
                                              count
                                          : googlemapprovider.distance
                                                  .ceilToDouble() *
                                              0 *
                                              count,
                              "Estimated Time":
                                  (googlemapprovider.time / 60).round(),
                              "Customer Number":
                                  SuccessPage.user!.phoneNumber.toString(),
                              "Customer Name": widget.username,
                              "Customer Id": widget.userid,
                              "Seats booked": count,
                              "customerimageurl": imageurl,
                              "drop off":
                                  googlemapprovider.endaddress.toString(),
                              "pickup":
                                  googlemapprovider.startingaddress.toString(),
                              "distance":
                                  googlemapprovider.distance.ceilToDouble(),
                              "afterstart":
                                  (DynamicRidesDetailScreen.isridestart)
                                      ? true
                                      : false
                            }
                          }
                        };

                        await rides.doc(widget.rideid).update(userdata);
                        ridestartprovider.setmapuserdata(userdatabooked);

                        googlemapprovider.markers.removeWhere(
                            (element) => element.markerId.value == '4');
                        googlemapprovider.markers.removeWhere(
                            (element) => element.markerId.value == '5');
                        googlemapprovider.unsetpickup();
                        googlemapprovider.unsetdropoff();

                        googlemapprovider.unsetDistance();
                        googlemapprovider.unsetTime();
                        googlemapprovider.markers.clear();
                        List<Location> locationsstart =
                            await locationFromAddress(widget.startingpoint);
                        List<Location> locationsend =
                            await locationFromAddress(widget.endpoint);
                        List<Location> locationsstartuser =
                            await locationFromAddress(
                                googlemapprovider.startingaddress);
                        List<Location> locationsenduser =
                            await locationFromAddress(
                                googlemapprovider.endaddress);
                        googlemapprovider.unsetStartingaddress();
                        googlemapprovider.unsetEndaddress();
                        ridestartprovider.markers.clear();
                        // ignore: use_build_context_synchronously
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomerBookingStartScreen(
                                  riderid: widget.riderid,
                                  usermarkerstartimage: usermarkerstartimage!,
                                  usermarkerendimage: usermarkerendimage!,
                                  userstartposition: LatLng(
                                      locationsstartuser.first.latitude,
                                      locationsstartuser.first.longitude),
                                  userendposition: LatLng(
                                      locationsenduser.first.latitude,
                                      locationsenduser.first.longitude),
                                  markerendimage: markerendimage!,
                                  markerstartimage: markerstartimage!,
                                  usersdata: ridestartprovider.userdata.entries
                                      .firstWhere((element) =>
                                          element.key == widget.userid)
                                      .value,
                                  userid: widget.userid,
                                  username: widget.username,
                                  cardid: widget.rideid,
                                  ridername: widget.ridername,
                                  vehiclemodel: widget.vehiclemodel,
                                  seats: ridestartprovider.userdata.entries
                                      .firstWhere((element) =>
                                          element.key == widget.userid)
                                      .value["Seats booked"],
                                  time: widget.time,
                                  date: widget.date,
                                  startingpoint: widget.startingpoint,
                                  endpoint: widget.endpoint,
                                  vehicleplatenumber: widget.vehicleplatenumber,
                                  endlatlong: LatLng(locationsend.last.latitude,
                                      locationsend.last.longitude),
                                  startlatlong: LatLng(
                                      locationsstart.last.latitude,
                                      locationsstart.last.longitude),
                                  imageurl: widget.imageurl,
                                  vehiclename: widget.vehiclename),
                            ));
                      },
                      child: Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "Request Booking",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  )
                : Container(
                    height: 35,
                    width: 285,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.grey,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "No Seats Avalible",
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
