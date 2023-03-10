import 'package:ezshare/Providers/ridecreateprovider.dart';
import 'package:ezshare/Riderscreens/screens/riderdestinationserach.dart';
import 'package:ezshare/Riderscreens/widgets/riderridecreateinfocard.dart';
import 'package:ezshare/Riderscreens/widgets/riderrideselectinfocard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ezshare/Riderscreens/screens/custommarker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class RiderRideCreateInfoScreen extends StatefulWidget {
  final String userid;
  final String username;
  final String sourcelocation;
  final String destinationlocation;
  final List<Location> sourcelist;
  final List<Location> destinationlist;
  final List<LatLng> polylines;
  static String sourcelocat = "";
  static String destinationlocat = ""; 
  const RiderRideCreateInfoScreen(
      {super.key,
      required this.sourcelocation,
      required this.destinationlocation,
      required this.userid,
      required this.username, required this.sourcelist, required this.destinationlist, required this.polylines});

  @override
  State<RiderRideCreateInfoScreen> createState() =>
      _RiderRideCreateInfoScreenState();
}

class _RiderRideCreateInfoScreenState extends State<RiderRideCreateInfoScreen> {
  Uint8List? markerimage, sourceimage;
  @override
  void initState() {
    super.initState();
    loadmarker();
     
  }

  

  loadmarker() {
    setState(() {
       CustomMarkerMaker()
          .custommarkerfromasset("assets/images/Vector-blue-dot.png")
          .then((value) => markerimage = value);
      CustomMarkerMaker()
          .custommarkerfromasset("assets/images/Vector-red.png")
          .then((value) => sourceimage = value);
    });
  }

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
                  RiderRideCreateInfoScreen.sourcelocat = widget.sourcelocation;
                  RiderRideCreateInfoScreen.destinationlocat = widget.destinationlocation;
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: RiderDestinationSerachScreen(
                            userid: widget.userid,
                            username: widget.username,
                          )));
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
        initialCameraPosition:  CameraPosition(
            target: LatLng(widget.sourcelist.last.latitude, widget.sourcelist.last.longitude), zoom: 14.4746),
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        onMapCreated: (controller) async { 
          
           loadmarker();
        },
        markers: <Marker>{
          Marker(
              icon: (sourceimage == null)? BitmapDescriptor.defaultMarker:  BitmapDescriptor.fromBytes(sourceimage!),
              markerId: const MarkerId("1"),
              position:   LatLng(widget.sourcelist.last.latitude, widget.sourcelist.last.longitude),
              infoWindow:  InfoWindow(title:  widget.sourcelocation)),
          Marker(
            markerId: const MarkerId("2"),
            icon: (markerimage == null)? BitmapDescriptor.defaultMarker: BitmapDescriptor.fromBytes(markerimage!),
            position:  LatLng(widget.destinationlist.last.latitude, widget.destinationlist.last.longitude),
            infoWindow:  InfoWindow(title: widget.destinationlocation),
          )
        },
        polylines: <Polyline>{
          Polyline(
              polylineId: const PolylineId('polyline_id'),
              points: widget.polylines,
              color: Colors.blueAccent,
              width: 4)
        },
      ),
      bottomNavigationBar: Consumer<RideCreateProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return (value.isSetvehicle == false)
              ? RiderRiderCreateInfoCard(
                  userid: widget.userid,
                  username: widget.username, 
                )
              : const RiderRideSelectInfoCard();
        },
      ),
    );
  }
}
