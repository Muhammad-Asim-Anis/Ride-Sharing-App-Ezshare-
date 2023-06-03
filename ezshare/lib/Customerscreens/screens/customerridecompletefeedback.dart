import 'package:ezshare/Customerscreens/widgets/riderfeedbackcard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerRideCompleteFeedbackScreen extends StatefulWidget {
   final String imageurl;
  final String userid;
  final String username;
  final String cardid;
  final String ridername;
  final String riderid;
  final int fare;
  const CustomerRideCompleteFeedbackScreen({super.key, required this.imageurl, required this.userid, required this.username, required this.cardid, required this.ridername, required this.riderid, required this.fare});

  @override
  State<CustomerRideCompleteFeedbackScreen> createState() => _CustomerRideCompleteFeedbackScreenState();
}

class _CustomerRideCompleteFeedbackScreenState extends State<CustomerRideCompleteFeedbackScreen> {
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.white,
          title: Text(
            "Rate Driver",
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
                  margin: const EdgeInsets.only(top: 15),
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
               RiderFeedbackCard(
                fare: widget.fare ,
                cardid: widget.cardid,
                  imageurl:widget.imageurl ,
                  riderid: widget.riderid,
                  ridername: widget.ridername,
                  userid: widget.userid,
                  username: widget.username,)
             
            ],
          ),
        ));
  }
}