// ignore_for_file: avoid_unnecessary_containers, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ezshare/BookingandHistoryscreens/widgets/inprogressridecard.dart';

import 'package:ezshare/Providers/googlemapprovider.dart';
import 'package:ezshare/Riderscreens/screens/custommarker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../Customerscreens/screens/customerbookingstart.dart';


import '../../Providers/ridestartprovider.dart';

class InprogressRidesScreen extends StatefulWidget {
  final String userid;
  final String username;
  const InprogressRidesScreen(
      {super.key, required this.userid, required this.username});

  @override
  State<InprogressRidesScreen> createState() => _InprogressRidesScreenState();
}

class _InprogressRidesScreenState extends State<InprogressRidesScreen> {
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");

  String riderid = "";

  String getrideStartedRiderid() {
    rides
        .where("users.${widget.userid}.Customer Id", isEqualTo: widget.userid)
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        setState(() {
          riderid = element["Riderid"];
        });
      }
    });

    return riderid;
  }

  @override
  Widget build(BuildContext context) {
    final googlemapprovider = Provider.of<GoogleMapProvider>(context);
    final ridestartprovider = Provider.of<RideStartProvider>(context);
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: rides
                .where("Riderid", isEqualTo: getrideStartedRiderid())
                .where("ridestart", isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Expanded(
                    child: Center(child: Text("No Started Ride Avaliable")));
              }

              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot ridesdetails =
                          snapshot.data!.docs[index];
                      Map<String, dynamic> users = ridesdetails["users"];

                      return InkWell(
                        onTap: () async {
                          Uint8List? markerstartimage;
                          Uint8List? markerendimage;
                          Uint8List? usermarkerstartimage;
                          Uint8List? usermarkerendimage;
                          googlemapprovider.markers.clear();
                          ridestartprovider.markers.clear();
                          await CustomMarkerMaker()
                              .custommarkerfromasset(
                                  "assets/images/Vector.png", 50, 50)
                              .then((value) => markerstartimage = value);
                          await CustomMarkerMaker()
                              .custommarkerfromasset(
                                  "assets/images/Vector-red.png", 50, 50)
                              .then((value) => markerendimage = value);
                          await CustomMarkerMaker()
                              .custommarkerfromasset(
                                  "assets/images/endpointmarker.png", 100, 100)
                              .then((value) => usermarkerendimage = value);
                          await CustomMarkerMaker()
                              .custommarkerfromasset(
                                  "assets/images/startingpointmarker.png",
                                  100,
                                  100)
                              .then((value) => usermarkerstartimage = value);

                          List<Location> locationsstartuser =
                              await locationFromAddress(users.entries
                                  .firstWhere(
                                      (element) => element.key == widget.userid)
                                  .value["pickup"]
                                  .toString());
                          List<Location> locationsenduser =
                              await locationFromAddress(users.entries
                                  .firstWhere(
                                      (element) => element.key == widget.userid)
                                  .value["drop off"]
                                  .toString());
                          googlemapprovider.markers.clear();
                          List<Location> locationsstart =
                              await locationFromAddress(
                                  ridesdetails['SourceLocation']);
                          List<Location> locationsend =
                              await locationFromAddress(
                                  ridesdetails['DestinationLocation']);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CustomerBookingStartScreen(
                                        markerendimage: markerendimage!,
                                        markerstartimage: markerstartimage!,
                                        userendposition: LatLng(
                                            locationsenduser.first.latitude,
                                            locationsenduser.first.longitude),
                                        usermarkerendimage: usermarkerendimage!,
                                        usermarkerstartimage:
                                            usermarkerstartimage!,
                                        usersdata: users.entries
                                            .firstWhere((element) =>
                                                element.key == widget.userid)
                                            .value,
                                        userstartposition: LatLng(
                                            locationsstartuser.first.latitude,
                                            locationsstartuser.first.longitude),
                                        riderid: ridesdetails["Riderid"],
                                        vehiclename: ridesdetails["Vehicle"],
                                        imageurl: ridesdetails["imageurl"],
                                        cardid: ridesdetails.id,
                                        userid: widget.userid,
                                        username: widget.username,
                                        date: ridesdetails['SelectedDate'],
                                        endpoint:
                                            ridesdetails['DestinationLocation'],
                                        ridername: ridesdetails['Ridername'],
                                        seats: ridesdetails['Seats'],
                                        startingpoint:
                                            ridesdetails['SourceLocation'],
                                        time: ridesdetails['SelectedTime'],
                                        vehiclemodel:
                                            ridesdetails['VehicleName'],
                                        vehicleplatenumber:
                                            ridesdetails['VehicleNumber'],
                                        endlatlong: LatLng(
                                            locationsend.last.latitude,
                                            locationsend.last.longitude),
                                        startlatlong: LatLng(
                                            locationsstart.last.latitude,
                                            locationsstart.last.longitude),
                                      )));
                        },
                        child: InProgressRideCard(
                          riderid: ridesdetails["Riderid"],
                          vehiclename: ridesdetails["Vehicle"],
                          usersdata: ridesdetails["users"],
                          imageurl: ridesdetails["imageurl"],
                          date: ridesdetails['SelectedDate'],
                          endpoint: ridesdetails['DestinationLocation'],
                          ridername: ridesdetails['Ridername'],
                          seats: ridesdetails['Seats'],
                          startingpoint: ridesdetails['SourceLocation'],
                          time: ridesdetails['SelectedTime'],
                          vehiclemodel: ridesdetails['VehicleName'],
                          rideid: ridesdetails.id,
                          userid: widget.userid,
                          username: widget.username,
                          vehicleplatenumber: ridesdetails['VehicleNumber'],
                        ),
                      );
                    }),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
