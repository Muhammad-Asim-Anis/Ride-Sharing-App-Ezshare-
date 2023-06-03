// ignore_for_file: camel_case_types, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Customerscreens/widgets/ride_card.dart';
import 'package:ezshare/Customerscreens/widgets/search_field.dart';
import 'package:ezshare/Providers/searchprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class first extends StatefulWidget {
  final String userid;
  final String username;
  const first({super.key, required this.userid, required this.username});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
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
                  if (count == 0) {
                    return const Center(child: Text("No Ride Avalible"));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot ridesdetails =
                          snapshot.data!.docs[index];

                      Map<String, dynamic> users = ridesdetails["users"];
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
                                  child: rideCard(
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
                                child: rideCard(
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
