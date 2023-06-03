import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Customerscreens/screens/customerbookedrides.dart';
import 'package:ezshare/Customerscreens/screens/customerridecompletefeedback.dart';
import 'package:ezshare/Customerscreens/widgets/messagecard.dart';
import 'package:ezshare/Providers/messageprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../Providers/ridestartprovider.dart';
import '../widgets/ridestart_card.dart';

class CustomerBookingStartScreen extends StatefulWidget {
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
  final Map<String, dynamic> usersdata;
  final Uint8List markerstartimage;
  final Uint8List markerendimage;
  final Uint8List usermarkerstartimage;
  final Uint8List usermarkerendimage;
  final LatLng userstartposition;
  final LatLng userendposition;
  final String riderid;

  const CustomerBookingStartScreen(
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
      required this.usersdata,
      required this.markerstartimage,
      required this.markerendimage,
      required this.userstartposition,
      required this.userendposition,
      required this.usermarkerstartimage,
      required this.usermarkerendimage,
      required this.riderid});

  @override
  State<CustomerBookingStartScreen> createState() =>
      _CustomerBookingStartScreenState();
}

class _CustomerBookingStartScreenState
    extends State<CustomerBookingStartScreen> {
  Uint8List? markerstartimage, markerendimage;
  List<Marker> marker = [];
  double latitude = 24.91638690588, longitude = 67.05699002225725;
  final Completer<GoogleMapController> controller = Completer();
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
  bool ridestart = false, isarrived = false, isstart = false, isend = false;
  List<LatLng> polylines = [];
  @override
  void initState() {
    super.initState();
    riderridestartcheck();
    ridearrivedcheck();
    ridestartcheck();
    rideendcheck(widget.usersdata["Estimated Fare"]);
  }

  rideendcheck(double fare) {
    rides.doc(widget.cardid).snapshots().listen((event) async {
      Map<String, dynamic> enduser = event["rideendparticipants"];

      try {
        isend = enduser.containsKey(widget.userid);

        if (isend) {
          rides.doc(widget.cardid).update({
            "users.${widget.userid}.start": false,
          });

          await Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.leftToRightWithFade,
                  child: CustomerRideCompleteFeedbackScreen(
                    fare: enduser.entries.firstWhere((element) => element.key == widget.userid).value["TotalFare"],
                    cardid: widget.cardid,
                    imageurl: widget.imageurl,
                    riderid: widget.riderid,
                    ridername: widget.ridername,
                    userid: widget.userid,
                    username: widget.username,
                  )));

          // ignore: use_build_context_synchronously
        }
      } catch (e) {
        isend = false;
      }
    });
  }

  ridearrivedcheck() {
    rides.doc(widget.cardid).snapshots().listen((event) {
      Map<String, dynamic> users = event["users"];
      setState(() async {
        try {
          isarrived = users.entries
              .firstWhere((element) => element.key == widget.userid)
              .value["arrived"];
        } catch (e) {
          isarrived = false;
        }
      });
    });
  }

  ridestartcheck() {
    rides.doc(widget.cardid).snapshots().listen((event) {
      Map<String, dynamic> users = event["users"];
      setState(() async {
        try {
          isstart = users.entries
              .firstWhere((element) => element.key == widget.userid)
              .value["start"];
          if (isstart) {
            await rides.doc(widget.cardid).update({
              "users.${widget.userid}.arrived": false,
            });
          }
        } catch (e) {
          isstart = false;
        }
        // ignore: use_build_context_synchronously
      });
    });
  }

  riderridestartcheck() {
    rides.doc(widget.cardid).snapshots().listen((event) {
      setState(() {
        ridestart = event["ridestart"];
      });
    });
  }

  loadpolyline() async {
    GoogleMapPolyline googleMapPolyline =
        GoogleMapPolyline(apiKey: "AIzaSyCPVtwUwZEhuK351SVc9sZ_cwGYOOvcJJk");
    polylines = (await googleMapPolyline.getCoordinatesWithLocation(
      origin:
          LatLng(widget.startlatlong.latitude, widget.startlatlong.longitude),
      destination:
          LatLng(widget.endlatlong.latitude, widget.endlatlong.longitude),
      mode: RouteMode.driving,
    ))!;
    setState(() {
      
    });
  }

  loadmarkerdata() {
    marker = [
      Marker(
          icon: BitmapDescriptor.fromBytes(widget.markerstartimage),
          markerId: const MarkerId("1"),
          position: widget.startlatlong,
          infoWindow: const InfoWindow(title: "Source Location")),
      Marker(
          icon: BitmapDescriptor.fromBytes(widget.markerendimage),
          markerId: const MarkerId("2"),
          position: widget.endlatlong,
          infoWindow: const InfoWindow(title: "Destination Location")),
      Marker(
          icon: BitmapDescriptor.fromBytes(widget.usermarkerstartimage),
          markerId: const MarkerId("3"),
          position: widget.userstartposition,
          infoWindow: const InfoWindow(title: " User Source Location")),
      Marker(
          icon: BitmapDescriptor.fromBytes(widget.usermarkerendimage),
          markerId: const MarkerId("4"),
          position: widget.userendposition,
          infoWindow: const InfoWindow(title: "User Destination Location")),
    ];
  }

  addmarker(RideStartProvider value) {
    if (value.markers != marker) {
      for (var element in marker) {
        value.markers.add(element);
      }
    }
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
                          child: CustomerBookedRidesScreen(
                            userid: widget.userid,
                            username: widget.username,
                          )));
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ))),
      ),
      body: Consumer<RideStartProvider>(
        builder: (context, value, child) {
          loadmarkerdata();
          addmarker(value);
          loadpolyline();
          // rideendcheck( widget.usersdata["Estimated Fare"]);
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(widget.startlatlong.latitude,
                        widget.startlatlong.longitude),
                    zoom: 14.4746),
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                compassEnabled: false,
                onMapCreated: (control) async {
                  controller.complete(control);
                },
                markers: value.markers.toSet(),
                polylines: <Polyline>{
          Polyline(
              polylineId: const PolylineId('polyline_id'),
              points: polylines,
              color: Colors.blueAccent,
              width: 4)
        },
              ),
              (ridestart && isarrived == false && isstart == false)
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2.0,
                                spreadRadius: .5,
                              )
                            ]),
                        margin: const EdgeInsets.only(top: 100),
                        child: const Center(
                            child: Text(
                          "Ride Has been started.Rider will arrive soon ",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    )
                  : (isarrived)
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(7),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                    spreadRadius: .5,
                                  )
                                ]),
                            margin: const EdgeInsets.only(top: 100),
                            child: const Center(
                                child: Text(
                              "Rider has been arrived at your location ",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            )),
                          ),
                        )
                      : (isstart)
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(7),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2.0,
                                        spreadRadius: .5,
                                      )
                                    ]),
                                margin: const EdgeInsets.only(top: 100),
                                child: const Center(
                                    child: Text(
                                  "Heading to the Destination",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            )
                          : const Align(),
            ],
          );
        },
      ),
      bottomNavigationBar: DraggableScrollableSheet(
        initialChildSize: (messageprovider.isClick) ? .7 : .6,
        minChildSize: .1,
        maxChildSize: .7,
        builder: (context, scrollController) {
          return SingleChildScrollView(
              controller: scrollController,
              child: Consumer<MessageCardProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return (value.isClick)
                      ? CustomerMessageCard(
                          reciverid: widget.riderid,
                          imageurl: widget.imageurl,
                          senderid: widget.userid,
                          username: widget.username,
                        )
                      : RideStartCard(
                          riderid: widget.riderid,
                          userstartpoint: widget.usersdata["pickup"],
                          userendpoint: widget.usersdata["drop off"],
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
                        );
                },
              ));
        },
      ),
    );
  }
}
