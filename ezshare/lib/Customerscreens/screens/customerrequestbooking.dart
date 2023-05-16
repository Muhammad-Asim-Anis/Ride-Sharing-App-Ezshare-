import 'dart:async';

import 'package:ezshare/Customerscreens/screens/cutomer_home.dart';
import 'package:ezshare/Customerscreens/widgets/messagecard.dart';
import 'package:ezshare/Customerscreens/widgets/requestbooking_card.dart';
import 'package:ezshare/Providers/googlemapprovider.dart';
import 'package:ezshare/Providers/messageprovider.dart';
import 'package:ezshare/Riderscreens/screens/custommarker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CustomerRequestBookingScreen extends StatefulWidget {
  final String imageurl;
  final String userid;
  final String username;
  final String cardid;
  final String ridername;
  final String vehiclemodel;
  final String vehicleplatenumber;
  final int seats;
  final String time;
  final String date;
  final String startingpoint;
  final String endpoint;
  final LatLng startlatlong;
  final LatLng endlatlong;
  final String vehiclename;
  final Map<String, dynamic> userdata;
  final String riderid;
  
  const CustomerRequestBookingScreen(
      {super.key,
      required this.userid,
      required this.username,
      required this.cardid,
      required this.ridername,
      required this.vehiclemodel,
      required this.seats,
      required this.time,
      required this.date,
      required this.startingpoint,
      required this.endpoint,
      required this.vehicleplatenumber,
      required this.startlatlong,
      required this.endlatlong,
      required this.imageurl,
      required this.vehiclename,
      required this.userdata, required this.riderid});

  @override
  State<CustomerRequestBookingScreen> createState() =>
      _CustomerRequestBookingScreenState();
}

class _CustomerRequestBookingScreenState
    extends State<CustomerRequestBookingScreen> {
  Uint8List? markerstartimage, markerendimage, usericonmarker;
  List<Marker> marker = [];
  double latitude = 24.91638690588, longitude = 67.05699002225725;
  final Completer<GoogleMapController> controller = Completer();
  String useraddress = "";
  @override
  void initState() {
    loaddata();
    // loadmarker();
    super.initState();
  }

  loadmarker() {
    CustomMarkerMaker()
        .custommarkerfromasset("assets/images/Vector.png", 50, 50)
        .then((value) => markerstartimage = value);
    CustomMarkerMaker()
        .custommarkerfromasset("assets/images/Vector-red.png", 50, 50)
        .then((value) => markerendimage = value);
    CustomMarkerMaker()
        .custommarkerfromasset("assets/images/usericon.png", 50, 50)
        .then((value) => usericonmarker = value);

    // setState(() {});
  }

  loadmarkerdata() {
    marker = [
      Marker(
          icon: BitmapDescriptor.fromBytes(markerstartimage!),
          markerId: const MarkerId("1"),
          position: widget.startlatlong,
          infoWindow: const InfoWindow(title: "Source Location")),
      Marker(
          icon: BitmapDescriptor.fromBytes(markerendimage!),
          markerId: const MarkerId("2"),
          position: widget.endlatlong,
          infoWindow: const InfoWindow(title: "Destination Location")),
    ];
  }

  loaddata() {
    getusercurrentposition().then((value) async {
      latitude = value.latitude;
      longitude = value.longitude;

      var addresses = await placemarkFromCoordinates(latitude, longitude);

      var first = addresses.first;
      var last = addresses.last;

      useraddress = "${first.name} ${last.street}";
      // RiderRideCreateInfoScreen.sourcelocat = useraddress;

      final GoogleMapController googleMapController = await controller.future;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 14.4746),
      ));
      // double distanceInMeters = Geolocator.distanceBetween(24.918617835716166,
      //     67.06161098335912, 24.86059737681838, 67.06993161219316);
      // print(distanceInMeters / 1000);

      loadmarkerdata();
      marker.add(
        Marker(
          icon: BitmapDescriptor.fromBytes(usericonmarker!),
          markerId: const MarkerId("3"),
          position: LatLng(latitude, longitude),
          infoWindow: const InfoWindow(title: "user location"),
        ),
      );
      setState(() {});
    });
  }

  Future<Position> getusercurrentposition() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  addmarker(GoogleMapProvider value) {
    for (var element in marker) {
      value.markers.add(element);
    }
  }

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
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: customerhome(
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
                  onTap: () {
                    loaddata();
                  },
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
      body: Stack(
        children: [
          Consumer<GoogleMapProvider>(
            builder: (context, value, child) {
              loadmarker();
              addmarker(value);
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(latitude, longitude), zoom: 14.4746),
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                compassEnabled: false,
                onMapCreated: (control) async {
                  controller.complete(control);
                },
                onCameraMove: (position) {
                  value.updatePosition(position.target);
                },
                markers: value.markers.toSet(),
                polylines: <Polyline>{
                  Polyline(
                      polylineId: const PolylineId("1"),
                      color: Colors.blueAccent,
                      points: <LatLng>[widget.startlatlong,widget.endlatlong])
                },
              );
            },
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(5),
              child: const Icon(Icons.location_on,
                  size: 50, color: Colors.blueAccent),
            ),
          )
        ],
      ),
      bottomNavigationBar: DraggableScrollableSheet(
        initialChildSize: .6,
        minChildSize: .1,
        maxChildSize: .7,
        builder: (context, scrollController) {
          return SingleChildScrollView(
              controller: scrollController,
              child: Consumer<MessageCardProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return (value.isClick)
                      ? CustomerMessageCard(reciverid: widget.riderid,
                        imageurl: widget.imageurl,
                          senderid: widget.userid,
                          username: widget.username,
                        )
                      : CustomerRequestBookingCard(
                        riderid: widget.riderid,
                          vehiclename: widget.vehiclename,
                          imageurl: widget.imageurl,
                          date: widget.date,
                          endpoint: widget.endpoint,
                          ridername: widget.ridername,
                          seats: widget.seats,
                          startingpoint: widget.startingpoint,
                          time: widget.time,
                          userid: widget.userid,
                          username: widget.username,
                          vehiclemodel: widget.vehiclemodel,
                          vehicleplatenumber: widget.vehicleplatenumber,
                          rideid: widget.cardid,
                          userdata: widget.userdata,
                        );
                },
              ));
        },
      ),
    );
  }
}
