import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Riderscreens/screens/custommarker.dart';
import 'package:ezshare/Riderscreens/screens/riderridedetails.dart';
import 'package:ezshare/Riderscreens/widgets/customer_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../Customerscreens/widgets/messagecard.dart';
import '../../Providers/messageprovider.dart';

class RiderRideDetailViewScreen extends StatefulWidget {
  final String userid;
  final String username;
  final String cardid;
  final List<Location> sourcelist;
  final List<Location> destinationlist;
  const RiderRideDetailViewScreen(
      {super.key,
      required this.userid,
      required this.username,
      required this.cardid,
      required this.sourcelist,
      required this.destinationlist});

  @override
  State<RiderRideDetailViewScreen> createState() =>
      _RiderRideDetailViewScreenState();
}

class _RiderRideDetailViewScreenState extends State<RiderRideDetailViewScreen> {
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
  final Completer<GoogleMapController> controller = Completer();
  Uint8List? markerimage, markerimage2, markerimage3;
  double startlatitude = 0.0,
      startlongitude = 0.0,
      endlatitude = 0.0,
      endlongitude = 0.0;
  @override
  void initState() {
    super.initState();
    loadmarker();
  }

  loadmarker() {
    startlatitude = widget.sourcelist.last.latitude;
    startlongitude = widget.sourcelist.last.longitude;
    endlatitude = widget.destinationlist.last.latitude;
    endlongitude = widget.destinationlist.last.longitude;
    CustomMarkerMaker()
        .custommarkerfromasset("assets/images/Vector-blue-dot.png")
        .then((value) => markerimage = value);

    CustomMarkerMaker()
        .custommarkerfromasset("assets/images/Vector-red.png")
        .then((value) => markerimage2 = value);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final messageprovider = Provider.of<MessageCardProvider>(context);
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
                          child: RiderRideBookingDeatilsScreen(
                            userid: widget.userid,
                            username: widget.username,
                          )));
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ))),
      ),
      body: GoogleMap(
        onTap: (argument) async {
          startlatitude = widget.sourcelist.last.latitude;
          startlongitude = widget.sourcelist.last.longitude;
          endlatitude = widget.destinationlist.last.latitude;
          endlongitude = widget.destinationlist.last.longitude;

          final GoogleMapController googleMapController =
              await controller.future;
          googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(startlatitude, endlongitude), zoom: 12),
          ));

          setState(() {});
        },
        onMapCreated: (control) {
          controller.complete(control);
          loadmarker();
        },
        initialCameraPosition: CameraPosition(
            target: LatLng(startlatitude, startlongitude), zoom: 14.4746),
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        markers: <Marker>{
          Marker(
              icon: (markerimage == null)
                  ? BitmapDescriptor.defaultMarker
                  : BitmapDescriptor.fromBytes(markerimage!),
              markerId: const MarkerId("1"),
              position: LatLng(
                startlatitude,
                startlongitude,
              ),
              infoWindow: const InfoWindow(title: "Source Location")),
          Marker(
            icon: (markerimage == null)
                ? BitmapDescriptor.defaultMarker
                : BitmapDescriptor.fromBytes(markerimage2!),
            markerId: const MarkerId("4"),
            position: LatLng(
              endlatitude,
              endlongitude,
            ),
            infoWindow: const InfoWindow(title: "destination Location"),
          )
        },
        polylines:  <Polyline>{
              Polyline(
  polylineId: const  PolylineId('polyline_1'),
  color: Colors.blue,
  points: <LatLng>[
    LatLng(startlatitude, startlongitude),
    LatLng(endlatitude, endlongitude)
  ],
)
        },
      ),
      bottomNavigationBar: DraggableScrollableSheet(
        initialChildSize: (messageprovider.isClick) ? .7 : .6,
        minChildSize: .1,
        maxChildSize: .7,
        expand: false,
        builder: (context, scrollController) {
          return StreamBuilder(
              stream: rides.doc(widget.cardid).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<dynamic> users = snapshot.data!.get("users");
                //  for (var element in users) {
                //      print(element);
                //   }
                return ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: (messageprovider.isClick)
                      ? messageprovider.itemcount
                      : users.length,
                  itemBuilder: (context, index) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Consumer<MessageCardProvider>(
                        builder: (BuildContext context, value, Widget? child) {
                      return (value.isClick)
                          ? CustomerMessageCard(
                              userid: widget.userid,
                              username: widget.username,
                            )
                          : InkWell(
                              onTap: () async {
                                startlatitude = 24.86060710532393;
                                startlongitude = 67.06985650841366;
                                endlatitude = 24.872316989499012;
                                endlongitude = 67.03401310841409;

                                final GoogleMapController googleMapController =
                                    await controller.future;
                                googleMapController.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                      target:
                                          LatLng(startlatitude, endlongitude),
                                      zoom: 13),
                                ));

                                setState(() {});
                              },
                              child: CustomerBookCard(
                                customername: "Asim",
                                vehiclemodel: "Honda-789",
                                seats: 1,
                                time: "2:00 PM",
                                date: "12-5-2023",
                                startingpoint: "hussainabad",
                                endpoint: "Sadar",
                                receiveid: widget.userid,
                                senderid: users[index],
                              ),
                            );
                    });
                  },
                );
              });
        },
      ),
    );
  }
}
