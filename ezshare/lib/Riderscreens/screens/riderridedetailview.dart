import 'package:ezshare/Riderscreens/screens/riderridedetails.dart';
import 'package:ezshare/Riderscreens/widgets/customer_card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';


class RiderRideDetailViewScreen extends StatefulWidget {
   final String userid;
  final String username; 
  const RiderRideDetailViewScreen({super.key, required this.userid, required this.username});

  @override
  State<RiderRideDetailViewScreen> createState() => _RiderRideDetailViewScreenState();
}

class _RiderRideDetailViewScreenState extends State<RiderRideDetailViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child:  
                  RiderRideBookingDeatilsScreen(
                    userid: widget.userid, username: widget.username,)  ));
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ))),
       
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
            target: LatLng(24.91638690588, 67.05699002225725), zoom: 14.4746),
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        markers: <Marker>{
          const Marker(
              markerId: MarkerId("1"),
              position: LatLng(24.91638690588, 67.05699002225725),
              infoWindow: InfoWindow(title: "Source Location")),
             const  Marker( markerId: MarkerId("2"),
              position: LatLng(24.902397373647943, 67.07289494395282),
              infoWindow: InfoWindow(title: "destination Location"),)
        },
      ),
      bottomNavigationBar: DraggableScrollableSheet(
          initialChildSize: .6,
          minChildSize: .1,
          maxChildSize: .7,
          expand: false,
          builder: (context, scrollController) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index)
            
             {
              return const CustomerBookCard(customername: "Asim", vehiclemodel: "Honda-789", seats: 1, time: "2:00 PM", date: "12-5-2023", startingpoint: "hussainabad", endpoint: "Sadar");
            },);
          },
        ), 
    );
  }
}