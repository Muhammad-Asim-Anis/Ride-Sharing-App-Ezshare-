// ignore_for_file: file_names

import 'package:ezshare/Riderscreens/widgets/customerfeedbackcard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class RiderRideCompleteFeedbackScreen extends StatefulWidget {
  const RiderRideCompleteFeedbackScreen({super.key});

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
                  onPressed: () {},
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
                height: 50,
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
                  height: 438,
                width: 300,
                child: ListView.builder(
                 
                 
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                  return const CustomerFeedbackCard();
                },),
              )
             
            ],
          ),
        ));
  }
}
