// ignore_for_file: camel_case_types, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Customerscreens/widgets/request_card.dart';
import 'package:ezshare/Customerscreens/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Providers/searchprovider.dart';

class DynamicRidesDetailScreen extends StatefulWidget {
  final String userid;
  final String username;
  static bool isridestart = false;
  const DynamicRidesDetailScreen(
      {super.key, required this.userid, required this.username});

  @override
  State<DynamicRidesDetailScreen> createState() =>
      _DynamicRidesDetailScreenState();
}

class _DynamicRidesDetailScreenState extends State<DynamicRidesDetailScreen> {
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  String imageurl = "";
  double rating = 0;
  String getuserimage(String userid) {
    users.doc(userid).get().then((value) async {
      try {
        imageurl = await value["imageurl"];
      } catch (e) {
        imageurl = "";
      }
    });
    return imageurl;
  }

  double ratingcalculate(String riderid) {
    users.doc(riderid).snapshots().listen((event) {
      setState(() {
        rating = event["Rating"] / event["Rides"];
      });
    });

    return rating;
  }

  @override
  Widget build(BuildContext context) {
    final searchprovider = Provider.of<SearchProvider>(context);
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            child: const SearchField(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: StreamBuilder(
                stream: rides
                    .where("Riderid", isNotEqualTo: widget.userid)
                    .where("ridestart", isEqualTo: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  int count = 0;
                  if (snapshot.data != null) {
                    for (var index = 0;
                        index < snapshot.data!.docs.length;
                        index++) {
                      final DocumentSnapshot ridesdetails =
                          snapshot.data!.docs[index];
                      Map<String, dynamic> users = ridesdetails["users"];
                      if (!users.keys.contains(widget.userid)) {
                        count++;
                      }
                    }
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text("No Started Ride Avaliable"));
                  }
                  if (count == 0) {
                    return const Center(child: Text("No Ride Avalible"));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot ridesdetails =
                          snapshot.data!.docs[index];
                      Map<String, dynamic> users = ridesdetails["users"];
                      DynamicRidesDetailScreen.isridestart = true;
                      if (ridesdetails["DestinationLocation"]
                              .toString()
                              .startsWith(searchprovider.searchval) &&
                          searchprovider.searchval.isNotEmpty) {
                        return (!users.keys.contains(widget.userid))
                            ? Center(
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  height: 230,
                                  width: 270,
                                  child: RequestRideCard(
                                    rating: double.parse(
                                        ratingcalculate(ridesdetails["Riderid"])
                                            .toStringAsFixed(1)),
                                    riderid: ridesdetails["Riderid"],
                                    vehiclename: ridesdetails["Vehicle"],
                                    usersdata: ridesdetails["users"],
                                    imageurl: ridesdetails["imageurl"],
                                    date: ridesdetails['SelectedDate'],
                                    endpoint:
                                        ridesdetails['DestinationLocation'],
                                    ridername: ridesdetails['Ridername'],
                                    seats: ridesdetails['Seats'],
                                    startingpoint:
                                        ridesdetails['SourceLocation'],
                                    time: ridesdetails['SelectedTime'],
                                    vehiclemodel: ridesdetails['VehicleName'],
                                    rideid: ridesdetails.id,
                                    userid: widget.userid,
                                    username: widget.username,
                                    vehicleplatenumber:
                                        ridesdetails['VehicleNumber'],
                                  ),
                                ),
                              )
                            : const Center();
                      }

                      return (!users.keys.contains(widget.userid) &&
                              searchprovider.searchval.isEmpty)
                          ? Center(
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                height: 230,
                                width: 270,
                                child: RequestRideCard(
                                  rating: double.parse(
                                      ratingcalculate(ridesdetails["Riderid"])
                                          .toStringAsFixed(1)),
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
                                  vehicleplatenumber:
                                      ridesdetails['VehicleNumber'],
                                ),
                              ),
                            )
                          : const Center();
                    },
                  );
                }),
          ),
        ),
      ],
    ));
  }
}
