import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Customerscreens/screens/cutomer_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:page_transition/page_transition.dart';

class RiderFeedbackCard extends StatefulWidget {
  final String imageurl;
  final String userid;
  final String username;
  final String cardid;
  final String ridername;
  final String riderid;
  final int fare;
  const RiderFeedbackCard(
      {super.key,
      required this.imageurl,
      required this.userid,
      required this.username,
      required this.cardid,
      required this.ridername,
      required this.riderid,
      required this.fare});

  @override
  State<RiderFeedbackCard> createState() => _RiderFeedbackCardState();
}

class _RiderFeedbackCardState extends State<RiderFeedbackCard> {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
    CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
  int rating  = 0;
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
                        color: Colors.blueAccent,
                        size: 100,
                      ),
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.ridername,
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              "Rs: ${widget.fare}",
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w600),
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
                controller: TextEditingController(),
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
                onTap: () async {
                  await users.doc(widget.riderid).update({
                    "Rides": FieldValue.increment(1),
                    "Rating": FieldValue.increment(rating)
                  });
                 await rides.doc(widget.cardid).update({
                  "rideendparticipants.${widget.userid}": FieldValue.delete()
                 });    
                 // ignore: use_build_context_synchronously
                 await  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: customerhome(
                              userid: widget.userid,
                              username: widget.username)));

                },
                child: Center(
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ),
          ]),
    );
  }
}
