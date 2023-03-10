import 'package:ezshare/Riderscreens/widgets/rider_card.dart';
import 'package:ezshare/homedrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderRideBookingDeatilsScreen extends StatefulWidget {
  final String userid;
  final String username; 
  const RiderRideBookingDeatilsScreen({super.key, required this.userid, required this.username});

  @override
  State<RiderRideBookingDeatilsScreen> createState() =>
      _RiderRideBookingDeatilsScreenState();
}

class _RiderRideBookingDeatilsScreenState
    extends State<RiderRideBookingDeatilsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blue, size: 40),
        title: Text(
          "Ride Details",
          style: GoogleFonts.poppins(
              color: Colors.blueAccent,
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder:(context, index) {
        return const  Center(
            child: RiderCard(
                    ridername: "Asim",
                    vehiclemodel: "honda-xyb",
                    seats: 2,
                    time: "2:00 PM",
                    date: "5/3/2023",
                    startingpoint: "hussainabad",
                    endpoint: "sadar"),
          );
      }, ),
      drawer:  HomeDrawer(username: widget.username, userid: widget.userid),
    );
  }
}
