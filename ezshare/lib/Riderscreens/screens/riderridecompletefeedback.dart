// ignore_for_file: file_names

import 'package:ezshare/Riderscreens/widgets/customerfeedbackcard.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderRideCompleteFeedbackScreen extends StatefulWidget {
  final String customername;
  final String startingpoint;
  final String endpoint;
  final String userid;
  final String imageurl;
  final String ridername;
  final String riderid;
  final List<Location> sourcelist;
  final List<Location> destinationlist;
  final int userlength;
  final int fare;
  final String cardid;
  final double distance;
  final int time;
  final String startdate;
  final String vehicleName;
  final String numberPlate;
  final String vehicle;
  final int seats;
  const RiderRideCompleteFeedbackScreen(
      {super.key,
      required this.customername,
      required this.startingpoint,
      required this.endpoint,
      required this.userid,
      required this.imageurl,
      required this.ridername,
      required this.sourcelist,
      required this.destinationlist,
      required this.userlength,
      required this.fare, required this.cardid, required this.riderid, required this.distance, required this.time, required this.startdate, required this.vehicleName, required this.numberPlate, required this.vehicle, required this.seats});

  @override
  State<RiderRideCompleteFeedbackScreen> createState() =>
      _RiderRideCompleteFeedbackScreenState();
}

class _RiderRideCompleteFeedbackScreenState
    extends State<RiderRideCompleteFeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.white,
          title: Text(
            "Rate Customer",
            style: GoogleFonts.poppins(
                color: Colors.blueAccent,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          leading: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(left: 4, right: 5),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  color: Colors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    )
                  ]),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ))),
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blueAccent),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
              ),
              Container(
                width: 95,
                height: 9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 12,
                        offset: Offset(0, 20),
                      )
                    ]),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Thank You!",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text(
                "You Successfully Complete Ride.",
                style: GoogleFonts.poppins(fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 450,
                width: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder: (context, index) {

                    return CustomerFeedbackCard(
                      seats: widget.seats,
                      vehicleName: widget.vehicleName,
                      vehicle: widget.vehicle ,
                      numberPlate: widget.numberPlate ,
                      startdate: widget.startdate,
                      time: widget.time,
                      distance: widget.distance,
                      riderid: widget.riderid,
                      cardid: widget.cardid,
                      customername: widget.customername,
                      destinationlist: widget.destinationlist,
                      endpoint: widget.endpoint,
                      fare: widget.fare,
                      imageurl: widget.imageurl,
                      ridername: widget.ridername,
                      sourcelist: widget.sourcelist,
                      startingpoint: widget.startingpoint,
                      userid: widget.userid,
                      userlength: widget.userlength,
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
