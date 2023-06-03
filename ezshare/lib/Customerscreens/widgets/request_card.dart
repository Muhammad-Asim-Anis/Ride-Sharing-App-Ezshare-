// ignore_for_file: camel_case_types, avoid_unnecessary_containers

import 'package:ezshare/Customerscreens/screens/customerbookingstart.dart';
import 'package:ezshare/Customerscreens/screens/customerrequestbooking.dart';
import 'package:ezshare/Providers/googlemapprovider.dart';
import 'package:ezshare/Providers/ridestartprovider.dart';
import 'package:ezshare/Riderscreens/screens/custommarker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class RequestRideCard extends StatefulWidget {
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
  final double rating;
  const RequestRideCard(
      {super.key,
      required this.ridername,
      required this.vehiclemodel,
      required this.seats,
      required this.time,
      required this.date,
      required this.startingpoint,
      required this.endpoint,
      required this.rideid,
      required this.userid,
      required this.username,
      required this.vehicleplatenumber,
      required this.imageurl,
      required this.usersdata,
      required this.vehiclename,
      required this.riderid, required this.rating});

  @override
  State<RequestRideCard> createState() => _RequestRideCardState();
}

class _RequestRideCardState extends State<RequestRideCard> {
  @override
  Widget build(BuildContext context) {
    final googlemapprovider = Provider.of<GoogleMapProvider>(context);
    final ridestartprovider = Provider.of<RideStartProvider>(context);
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
                                  color: Colors.blue,
                                  size: 90,
                                ),
                              ),
                      ),
                      SizedBox(
                          width: 170,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.zero,
                                child: Column(children: [
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
                                child: Column(children: [
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
                            SizedBox(
                              width: 200,
                              height: 10,
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
                            const Text(
                              "Ending point",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            SizedBox(
                              width: 200,
                              height: 10,
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
                            child: (!widget.usersdata.keys
                                    .contains(widget.userid))
                                ? InkWell(
                                    onTap: () async {
                                      googlemapprovider.markers.clear();
                                      List<Location> locationsstart =
                                          await locationFromAddress(
                                              widget.startingpoint);
                                      List<Location> locationsend =
                                          await locationFromAddress(
                                              widget.endpoint);
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CustomerRequestBookingScreen(
                                                  
                                                    riderid: widget.riderid,
                                                    vehiclename:
                                                        widget.vehiclename,
                                                    imageurl: widget.imageurl,
                                                    cardid: widget.rideid,
                                                    userid: widget.userid,
                                                    username: widget.username,
                                                    date: widget.date,
                                                    endpoint: widget.endpoint,
                                                    ridername: widget.ridername,
                                                    seats: widget.seats,
                                                    startingpoint:
                                                        widget.startingpoint,
                                                    time: widget.time,
                                                    vehiclemodel:
                                                        widget.vehiclemodel,
                                                    vehicleplatenumber: widget
                                                        .vehicleplatenumber,
                                                    endlatlong: LatLng(
                                                        locationsend
                                                            .last.latitude,
                                                        locationsend
                                                            .last.longitude),
                                                    startlatlong: LatLng(
                                                        locationsstart
                                                            .last.latitude,
                                                        locationsstart
                                                            .last.longitude),
                                                    userdata: widget.usersdata,
                                                  )));
                                    },
                                    child: Center(
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "Request",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      Uint8List? markerstartimage;
                                      Uint8List? markerendimage;
                                      Uint8List? usermarkerstartimage;
                                      Uint8List? usermarkerendimage;
                                      googlemapprovider.markers.clear();
                                      ridestartprovider.markers.clear();
                                      await CustomMarkerMaker()
                                          .custommarkerfromasset(
                                              "assets/images/Vector.png",
                                              50,
                                              50)
                                          .then((value) =>
                                              markerstartimage = value);
                                      await CustomMarkerMaker()
                                          .custommarkerfromasset(
                                              "assets/images/Vector-red.png",
                                              50,
                                              50)
                                          .then((value) =>
                                              markerendimage = value);
                                      await CustomMarkerMaker()
                                          .custommarkerfromasset(
                                              "assets/images/endpointmarker.png",
                                              100,
                                              100)
                                          .then((value) =>
                                              usermarkerendimage = value);
                                      await CustomMarkerMaker()
                                          .custommarkerfromasset(
                                              "assets/images/startingpointmarker.png",
                                              100,
                                              100)
                                          .then((value) =>
                                              usermarkerstartimage = value);
                                      List<Location> locationsstart =
                                          await locationFromAddress(
                                              widget.startingpoint);
                                      List<Location> locationsend =
                                          await locationFromAddress(
                                              widget.endpoint);
                                      List<Location> locationsstartuser =
                                          await locationFromAddress(widget
                                              .usersdata.entries
                                              .firstWhere((element) =>
                                                  element.key == widget.userid)
                                              .value["pickup"]
                                              .toString());
                                      List<Location> locationsenduser =
                                          await locationFromAddress(widget
                                              .usersdata.entries
                                              .firstWhere((element) =>
                                                  element.key == widget.userid)
                                              .value["drop off"]
                                              .toString());

                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CustomerBookingStartScreen(
                                                  
                                                    riderid: widget.riderid,
                                                    usermarkerstartimage:
                                                        usermarkerstartimage!,
                                                    usermarkerendimage:
                                                        usermarkerendimage!,
                                                    markerendimage:
                                                        markerendimage!,
                                                    markerstartimage:
                                                        markerstartimage!,
                                                    usersdata: widget
                                                        .usersdata.entries
                                                        .firstWhere((element) =>
                                                            element.key ==
                                                            widget.userid)
                                                        .value,
                                                    vehiclename:
                                                        widget.vehiclename,
                                                    imageurl: widget.imageurl,
                                                    cardid: widget.rideid,
                                                    userid: widget.userid,
                                                    username: widget.username,
                                                    date: widget.date,
                                                    endpoint: widget.endpoint,
                                                    ridername: widget.ridername,
                                                    seats: widget.seats,
                                                    startingpoint:
                                                        widget.startingpoint,
                                                    time: widget.time,
                                                    vehiclemodel:
                                                        widget.vehiclemodel,
                                                    vehicleplatenumber: widget
                                                        .vehicleplatenumber,
                                                    endlatlong: LatLng(
                                                        locationsend
                                                            .last.latitude,
                                                        locationsend
                                                            .last.longitude),
                                                    startlatlong: LatLng(
                                                        locationsstart
                                                            .last.latitude,
                                                        locationsstart
                                                            .last.longitude),
                                                    userendposition: LatLng(
                                                        locationsenduser
                                                            .first.latitude,
                                                        locationsenduser
                                                            .first.longitude),
                                                    userstartposition: LatLng(
                                                        locationsstartuser
                                                            .first.latitude,
                                                        locationsstartuser
                                                            .first.longitude),
                                                  )));
                                    },
                                    child: Center(
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "View now",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
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
