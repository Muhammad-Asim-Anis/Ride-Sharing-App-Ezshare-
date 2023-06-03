import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Riderscreens/screens/riderridedetailview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerCancelTripScreen extends StatefulWidget {
  final String userid;
  final String username;
  final String ridername;
  final String vehiclemodel;
  final int seats;
  final String time;
  final String date;
  final String startingpoint;
  final String endpoint;
  final String rideid;
  final String imageurl;
  final bool ridestart;
  final bool arrived;
  final String riderid;
  final List<Location> sourcelist;
  final List<Location> destinationlist;
  final int userlength;
  const CustomerCancelTripScreen(
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
      required this.rideid,
      required this.imageurl,
      required this.riderid,
      required this.ridestart,
      required this.arrived,
      required this.sourcelist,
      required this.destinationlist,
      required this.userlength});

  @override
  State<CustomerCancelTripScreen> createState() =>
      _CustomerCancelTripScreenState();
}

class _CustomerCancelTripScreenState extends State<CustomerCancelTripScreen> {
  CollectionReference wallet =
      FirebaseFirestore.instance.collection("Wallet_Recipt");
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  List<String> canceltrip = [
    "Waiting for a long time",
    "Customer isn’t there",
    "Wrong address",
    "Customer didn’t Pick",
    "Cacelling myself",
    "Other",
  ];
  List<bool> canceltripclicks = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: Text(
          "Cancel Trip",
          style: GoogleFonts.poppins(
              color: Colors.blueAccent,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        leading: SizedBox(
            width: 10,
            height: 10,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  CupertinoIcons.multiply,
                  size: 30,
                  color: Colors.blueAccent,
                ))),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 10, bottom: 10),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: canceltrip.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (canceltripclicks[index] == false) {
                          canceltripclicks[index] = true;
                        } else {
                          canceltripclicks[index] = false;
                        }
                      });
                    },
                    splashColor: Colors.white,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              (canceltripclicks[index] == true)
                                  ? Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      width: 27,
                                      height: 27,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.blueAccent),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      width: 27,
                                      height: 27,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.grey),
                                    ),
                              Text(
                                canceltrip[index],
                                style: GoogleFonts.poppins(
                                    color: Colors.blueAccent,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                            child: Center(
                              child: Container(
                                margin: const EdgeInsetsDirectional.only(
                                    start: 0.0, end: 0.0),
                                height: 1.0,
                                width: 400,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            InkWell(
                onTap: () async {
                  await wallet.doc().set({
                    "Userstartlocation": widget.startingpoint,
                    "Userendlocation": widget.endpoint,
                    "userId": widget.riderid,
                    "Name": widget.ridername,
                    "id" : widget.userid,
                    "username" : widget.username,
                    "Seat booked" : widget.seats,
                    "Amount": 0,
                    "participants" : [widget.userid,widget.riderid],
                    "Fare": (widget.ridestart == false)
                        ? 0
                        : (widget.ridestart && widget.arrived == false)
                            ? 5
                            : (widget.ridestart && widget.arrived)
                                ? 10
                                : 0,
                    "Check": "Penalty", 
                    "Cencel by" : "Rider Cancel",
                    "message": canceltrip[canceltripclicks.indexOf(true)],
                    "Date": DateTime.now().toString(),
                  });
                    await users
                      .doc(widget.userid)
                      .update({"Rides": FieldValue.increment(1)});
                  // await rides
                  //     .doc(widget.rideid)
                  //     .update({"users.${widget.userid}": FieldValue.delete()});

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RiderRideDetailViewScreen(
                          userid: widget.userid,
                          username: widget.username,
                          cardid: widget.rideid,
                          destinationlist: widget.destinationlist,
                          sourcelist: widget.sourcelist,
                          userlength: widget.userlength,
                        ),
                      ));
                },
                hoverColor: Colors.white,
                child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue, width: 1)),
                      width: 287,
                      height: 63,
                      child: Center(
                        child: Text(
                          "Done",
                          style: GoogleFonts.poppins(
                              fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
