import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Riderscreens/widgets/rider_card.dart';
import 'package:ezshare/homedrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderRideBookingDeatilsScreen extends StatefulWidget {
  final String userid;
  final String username;
  const RiderRideBookingDeatilsScreen(
      {super.key, required this.userid, required this.username});

  @override
  State<RiderRideBookingDeatilsScreen> createState() =>
      _RiderRideBookingDeatilsScreenState();
}

class _RiderRideBookingDeatilsScreenState
    extends State<RiderRideBookingDeatilsScreen> {
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
 
 
 


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
      body: StreamBuilder(
          stream: rides.snapshots(),
          builder: (context, snapshot) {
            
             
            if (!snapshot.hasData) {
             
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
               
                final DocumentSnapshot ridesdetails =
                    snapshot.data!.docs[index];
                return Center(
                  child: RiderCard(
                    ridername: ridesdetails["Ridername"],
                    vehiclemodel: ridesdetails["VehicleNumber"],
                    seats: ridesdetails["Seats"],
                    time: ridesdetails["SelectedTime"],
                    date: ridesdetails["SelectedDate"],
                    startingpoint: ridesdetails["SourceLocation"],
                    endpoint: ridesdetails["DestinationLocation"],
                    userid: widget.userid,
                    username: widget.username,
                    cardid: ridesdetails.id,
                    usersData: ridesdetails["users"],
                    imageurl: ridesdetails["imageurl"],
                  ),
                );
              },
            );
          }),
      drawer: HomeDrawer(username: widget.username, userid: widget.userid),
    );
  }
}
