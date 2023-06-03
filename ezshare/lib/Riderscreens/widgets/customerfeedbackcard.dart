import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Riderscreens/screens/riderridedetailview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class CustomerFeedbackCard extends StatefulWidget {
  final String customername;
  final String startingpoint;
  final String endpoint;
  final String userid;
  final String imageurl;
  final String ridername;
  final List<Location> sourcelist;
  final List<Location> destinationlist;
  final int userlength;
  final int fare;
  final String riderid;
  final String cardid;
  final double distance;
  final int time;
  final String startdate;
  final String vehicleName;
  final String numberPlate;
  final String vehicle;
  final int seats;
  const CustomerFeedbackCard(
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
      required this.fare,
      required this.cardid,
      required this.riderid,
      required this.distance,
      required this.time,
      required this.startdate,
      required this.vehicleName,
      required this.numberPlate,
      required this.vehicle,
      required this.seats});

  @override
  State<CustomerFeedbackCard> createState() => _CustomerFeedbackCardState();
}

class _CustomerFeedbackCardState extends State<CustomerFeedbackCard> {
  CollectionReference wallet =
      FirebaseFirestore.instance.collection("Wallet_Recipt");
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
  TextEditingController messagefeedback = TextEditingController();
  int balance = 0;
  int amount = 0;
  int fareuser = 0;
  TextEditingController? fare;
  int rating = 0;
  @override
  void initState() {
    super.initState();
    checkremainingbalance();
  }

  int checkremainingbalance() {
    wallet
        .where("userId", isEqualTo: widget.userid)
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        amount = element["Amount"];
        fareuser = element["Fare"];

        balance += amount - fareuser;
      }

      fare = TextEditingController(text: (widget.fare - balance).toString());
      setState(() {});
    });
    return balance;
  }

  String formatDate(String inputDate) {
    DateTime date = DateTime.parse(inputDate);
    String formattedDate =
        DateFormat.MMMM().format(date); // Get the full month name
    int day = date.day;

    return '$formattedDate $day';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 438,
      width: 275,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 3),
            )
          ]),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 122,
              width: 149,
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
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.customername,
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: TextField(
                textAlign: TextAlign.center,
                enableSuggestions: false,
                controller: fare,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 0, color: Color.fromARGB(255, 235, 235, 235)),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 0, color: Color.fromARGB(255, 235, 235, 235)),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 0, color: Color.fromARGB(255, 235, 235, 235)),
                    borderRadius: BorderRadius.circular(13),
                  ),

                  fillColor: const Color.fromARGB(255, 235, 235, 235),
                  hintText: "Fare",
                  // prefixIcon: Icon(CupertinoIcons.search),
                ),
              ),
            ),
            Text(
              "Rate Your Trip",
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
            ),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star_rate_rounded,
                color: Colors.blueAccent,
              ),
              onRatingUpdate: (ratinguser) {
                setState(() {
                  rating = ratinguser.toInt();
                });
              },
            ),
            Container(
              height: 80,
              width: 187,
              padding: const EdgeInsets.only(left: 10, right: 10),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: TextField(
                controller: messagefeedback,
                decoration: InputDecoration(
                  hintText: "Write a Comments",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 33,
              width: 187,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.blue,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RiderRideDetailViewScreen(
                          userid: widget.userid,
                          username: widget.customername,
                          cardid: widget.cardid,
                          destinationlist: widget.destinationlist,
                          sourcelist: widget.sourcelist,
                          userlength: widget.userlength,
                        ),
                      ));
                },
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      await wallet.doc().set({
                        "Userstartlocation": widget.startingpoint,
                        "Userendlocation": widget.endpoint,
                        "userId": widget.userid,
                        "Name": widget.customername,
                        "id": widget.riderid,
                        "username": widget.ridername,
                        "Amount": int.parse(fare!.text),
                        "participants": [widget.userid, widget.riderid],
                        "Fare": widget.fare,
                        "Total Time": widget.time,
                        "Check": "topup",
                        "Rating": rating,
                        "status": "Completed",
                        "message": messagefeedback.text.toString(),
                        "Vehicletype": widget.vehicle,
                        "Number plate": widget.numberPlate,
                        "Vehicle": widget.vehicleName,
                        "Seats": widget.seats,
                        "remainbalance" : checkremainingbalance(),
                        "startdate":
                            "${formatDate(widget.startdate)}, ${DateFormat.jm().format(DateTime.parse(widget.startdate))} ",
                        "Date": DateFormat.jm().format(DateTime.now()),
                        "Distance": widget.distance,
                      });

                      await rides.doc(widget.cardid).update({
                        "rideendparticipants.${widget.userid}": 
                        {
                          "TotalFare" : int.parse(fare!.text)
                        },
                      });

                      await users.doc(widget.userid).update({
                        "Rides": FieldValue.increment(1),
                        "Rating": FieldValue.increment(rating)
                      });

                      await rides.doc(widget.cardid).update({
                        "users.${widget.userid}":FieldValue.delete()
                      });
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RiderRideDetailViewScreen(
                              userid: widget.userid,
                              username: widget.customername,
                              cardid: widget.cardid,
                              destinationlist: widget.destinationlist,
                              sourcelist: widget.sourcelist,
                              userlength: widget.userlength,
                            ),
                          ));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
