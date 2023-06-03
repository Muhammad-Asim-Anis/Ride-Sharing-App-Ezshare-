// ignore_for_file: avoid_unnecessary_containers, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ezshare/BookingandHistoryscreens/widgets/inprogressridecard.dart';


import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../../Riderscreens/screens/riderridedetailview.dart';

class InprogressRidesRiderScreen extends StatefulWidget {
  final String userid;
  final String username;
  const InprogressRidesRiderScreen(
      {super.key, required this.userid, required this.username});

  @override
  State<InprogressRidesRiderScreen> createState() =>
      _InprogressRidesRiderScreenState();
}

class _InprogressRidesRiderScreenState
    extends State<InprogressRidesRiderScreen> {
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");

  @override
  Widget build(BuildContext context) {
   
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
                .where("Riderid", isEqualTo: widget.userid)
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
                          List<Location> locationssource =
                              await locationFromAddress(
                                  ridesdetails['SourceLocation'].toString());

                          List<Location> locationsdestination =
                              await locationFromAddress(
                                  ridesdetails['DestinationLocation']
                                      .toString());
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RiderRideDetailViewScreen(
                                  userid: widget.userid,
                                  username: widget.username,
                                  cardid: ridesdetails.id,
                                  destinationlist: locationsdestination,
                                  sourcelist: locationssource,
                                  userlength: users.length,
                                ),
                              ));
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
