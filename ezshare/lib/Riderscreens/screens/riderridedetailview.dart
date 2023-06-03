import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Riderscreens/screens/custommarker.dart';
import 'package:ezshare/Riderscreens/screens/riderridedetails.dart';
import 'package:ezshare/Riderscreens/widgets/customer_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
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
  final int userlength;
  const RiderRideDetailViewScreen(
      {super.key,
      required this.userid,
      required this.username,
      required this.cardid,
      required this.sourcelist,
      required this.destinationlist,
      required this.userlength});

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
  List<LatLng> polylines = [];
  @override
  void initState() {
    super.initState();
    loadmarker();
    loadpolyline();
  }

  loadpolyline() async {
    GoogleMapPolyline googleMapPolyline =
        GoogleMapPolyline(apiKey: "AIzaSyCPVtwUwZEhuK351SVc9sZ_cwGYOOvcJJk");
    polylines = (await googleMapPolyline.getCoordinatesWithLocation(
      origin: LatLng(startlatitude, startlongitude),
      destination: LatLng(endlatitude, endlongitude),
      mode: RouteMode.driving,
    ))!;
    setState(() {});
  }

  loadmarker() {
    startlatitude = widget.sourcelist.last.latitude;
    startlongitude = widget.sourcelist.last.longitude;
    endlatitude = widget.destinationlist.last.latitude;
    endlongitude = widget.destinationlist.last.longitude;
    CustomMarkerMaker()
        .custommarkerfromasset("assets/images/Vector-blue-dot.png", 50, 50)
        .then((value) => markerimage = value);

    CustomMarkerMaker()
        .custommarkerfromasset("assets/images/Vector-red.png", 50, 50)
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
          await loadpolyline();
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
        polylines: <Polyline>{
          Polyline(
              width: 5,
              polylineId: const PolylineId('polyline_1'),
              color: Colors.blue,
              points: polylines)
        },
      ),
      bottomNavigationBar: DraggableScrollableSheet(
        initialChildSize: (widget.userlength != 0)
            ? (messageprovider.isClick)
                ? .7
                : .6
            : .1,
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
                String riderid = snapshot.data!.get("Riderid");
                String ridername = snapshot.data!.get("Ridername");
                Map<String, dynamic> users = snapshot.data!.get("users");
                bool ridestart;
                try {
                  ridestart = snapshot.data!.get("ridestart");
                } catch (e) {
                  ridestart = false;
                }
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: (ridestart != true)
                          ? InkWell(
                              onTap: () async {
                                await rides
                                    .doc(widget.cardid)
                                    .update({"ridestart": true});
                              },
                              child: Container(
                                  width: 100,
                                  height: 40,
                                  margin: const EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(50, 0, 0, 0),
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                          offset: Offset(0, 4),
                                        )
                                      ]),
                                  child: const Center(
                                    child: Text("On my way",
                                        style: TextStyle(color: Colors.white)),
                                  )),
                            )
                          : InkWell(
                              onTap: () async {
                               await rides.doc(widget.cardid).delete();
                                // ignore: use_build_context_synchronously
                                await Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType
                                            .rightToLeftWithFade,
                                        child: RiderRideBookingDeatilsScreen(
                                          userid: widget.userid,
                                          username: widget.username,
                                        )));
                              },
                              child: Container(
                                  width: 100,
                                  height: 40,
                                  margin: const EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(50, 0, 0, 0),
                                          spreadRadius: 0,
                                          blurRadius: 4,
                                          offset: Offset(0, 4),
                                        )
                                      ]),
                                  child: const Center(
                                    child: Text("end",
                                        style: TextStyle(color: Colors.white)),
                                  )),
                            ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: (messageprovider.isClick)
                            ? messageprovider.itemcount
                            : users.length,
                        itemBuilder: (context, index) {
                          bool afterridestart = false;
                          try {
                            afterridestart = users.entries
                                .elementAt(index)
                                .value["afterstart"];
                          } catch (e) {
                            afterridestart = false;
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return Consumer<MessageCardProvider>(builder:
                              (BuildContext context, value, Widget? child) {
                            return (value.isClick)
                                ? CustomerMessageCard(
                                    senderid: riderid,
                                    imageurl: users.entries
                                        .elementAt(index)
                                        .value["customerimageurl"],
                                    reciverid: widget.userid,
                                    username: widget.username,
                                  )
                                : InkWell(
                                    onTap: () async {
                                      List<Location> start =
                                          await locationFromAddress(users
                                              .entries
                                              .elementAt(index)
                                              .value["pickup"]);
                                      List<Location> end =
                                          await locationFromAddress(users
                                              .entries
                                              .elementAt(index)
                                              .value["drop off"]);
                                      startlatitude = start.first.latitude;
                                      startlongitude = start.first.longitude;
                                      endlatitude = end.first.latitude;
                                      endlongitude = end.first.longitude;
                                      await loadpolyline();
                                      final GoogleMapController
                                          googleMapController =
                                          await controller.future;
                                      googleMapController.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: LatLng(
                                                startlatitude, endlongitude),
                                            zoom: 13),
                                      ));

                                      setState(() {});
                                    },
                                    child: CustomerBookCard(
                                      vehicle:
                                          snapshot.data!.get("VehicleName"),
                                      fare: users.entries
                                          .elementAt(index)
                                          .value["Estimated Fare"],
                                      vehiclename:
                                          snapshot.data!.get("Vehicle"),
                                      distance: users.entries
                                          .elementAt(index)
                                          .value["distance"],
                                      usertime: users.entries
                                          .elementAt(index)
                                          .value["Estimated Time"],
                                      destinationlist: widget.destinationlist,
                                      sourcelist: widget.sourcelist,
                                      userlength: widget.userlength,
                                      ridestart: ridestart,
                                      ridername: ridername,
                                      afterstart: afterridestart,
                                      rideid: widget.cardid,
                                      usercontact: users.entries
                                          .elementAt(index)
                                          .value["Customer Number"],
                                      imageurl: users.entries
                                          .elementAt(index)
                                          .value["customerimageurl"],
                                      customername: users.entries
                                          .elementAt(index)
                                          .value["Customer Name"],
                                      vehiclemodel:
                                          snapshot.data!.get("VehicleNumber"),
                                      seats: users.entries
                                          .elementAt(index)
                                          .value["Seats booked"],
                                      time: snapshot.data!.get("SelectedTime"),
                                      date: snapshot.data!.get("SelectedDate"),
                                      startingpoint: users.entries
                                          .elementAt(index)
                                          .value["pickup"],
                                      endpoint: users.entries
                                          .elementAt(index)
                                          .value["drop off"],
                                      receiveid: (users.isEmpty)
                                          ? ""
                                          : users.entries.elementAt(index).key,
                                      senderid: riderid,
                                    ),
                                  );
                          });
                        },
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
