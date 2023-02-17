
import 'package:ezshare/Providers/ridecreateprovider.dart';
import 'package:ezshare/Riderscreens/screens/riderdestinationserach.dart';
import 'package:ezshare/Riderscreens/widgets/riderridecreateinfocard.dart';
import 'package:ezshare/Riderscreens/widgets/riderrideselectinfocard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class RiderRideCreateInfoScreen extends StatefulWidget {
  final String userid;
  final String username;
  final String sourcelocation;
  final String destinationlocation; 
  const RiderRideCreateInfoScreen({super.key, required this.sourcelocation, required this.destinationlocation, required this.userid, required this.username});

  @override
  State<RiderRideCreateInfoScreen> createState() =>
      _RiderRideCreateInfoScreenState();
}

class _RiderRideCreateInfoScreenState extends State<RiderRideCreateInfoScreen> {
 
  
 
  // List<LatLng> polylines = [];
  // GoogleMapPolyline googleMapPolyline =
  //     GoogleMapPolyline(apiKey: "AIzaSyCPVtwUwZEhuK351SVc9sZ_cwGYOOvcJJk");

  // destinationtopolylines() async {
  //   polylines = (await googleMapPolyline.getCoordinatesWithLocation(
  //     origin: const LatLng(24.91638690588, 67.05699002225725),
  //     destination: const LatLng(24.86149386345483, 67.01537192559961),
  //     mode: RouteMode.driving,
  //   ))!;
  //   print(polylines);
  // }

 

  

 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
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
                  RiderDestinationSerachScreen(
                    userid: widget.userid, username: widget.username,)  ));
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ))),
        actions: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                width: 100,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.my_location_outlined,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Location",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                )),
          )
        ],
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
      bottomNavigationBar: Consumer<RideCreateProvider>(
        builder: (BuildContext context, value, Widget? child) { 
          return (value.isSetvehicle == false)
            ?  RiderRiderCreateInfoCard(userid: widget.userid, username: widget.username,)
            : const RiderRideSelectInfoCard();
         },
        
      ),
    );
  }
}
