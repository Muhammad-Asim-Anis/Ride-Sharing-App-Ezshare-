// ignore_for_file: camel_case_types, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Customerscreens/widgets/ride_card.dart';
import 'package:ezshare/Customerscreens/widgets/search_field.dart';
import 'package:flutter/material.dart';

class first extends StatefulWidget {
  const first({super.key});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
  @override
  Widget build(BuildContext context) {
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
                stream: rides.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child:  CircularProgressIndicator());
                  }
            
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
            
                    itemBuilder: (context, index) {
                      final DocumentSnapshot ridesdetails =
                                        snapshot.data!.docs[index];
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          height: 230,
                          width: 270,
                          child:  rideCard(
                            date: ridesdetails['SelectedDate'],
                            endpoint: '',
                            ridername: ridesdetails['Ridername'],
                            seats: ridesdetails['Seats'],
                            startingpoint: '',
                            time: ridesdetails['SelectedTime'],
                            vehiclemodel: ridesdetails['VehicleName'],
                          ),
                        ),
                      );
                    },
                  );
                }),
                ),
            ),
          ],
        ));
  }
}
