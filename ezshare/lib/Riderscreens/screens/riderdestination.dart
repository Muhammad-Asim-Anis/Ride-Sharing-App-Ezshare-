// ignore_for_file: file_names

import 'package:ezshare/Riderscreens/screens/custommarker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ezshare/Riderscreens/screens/riderdestinationserach.dart';
import 'package:ezshare/homedrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';

class RiderDestinationSetScreen extends StatefulWidget {
  final String username;
  final String userid;
  const RiderDestinationSetScreen(
      {super.key, required this.username, required this.userid});

  @override
  State<RiderDestinationSetScreen> createState() =>
      _RiderDestinationSetScreenState();
}

class _RiderDestinationSetScreenState extends State<RiderDestinationSetScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  TextEditingController sourcelocation = TextEditingController();
  TextEditingController destinationlocaton = TextEditingController();
  Uint8List? markerimage;
  double latitude = 24.91638690588, longitude = 67.05699002225725;
  @override
  initState() {
    super.initState();
    loaddata();
    loadmarker();
  }

  loadmarker() {
    setState(() {
      CustomMarkerMaker()
          .custommarkerfromasset("assets/images/Vector.png")
          .then((value) => markerimage = value);
    });
  }

  loaddata() {
    getusercurrentposition().then((value) async {
      
      setState(() {
        latitude = value.latitude;
        longitude = value.longitude;
      });
    });
  }

  Future<Position> getusercurrentposition() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          leading: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: IconButton(
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                size: 34,
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.zero,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.blue,
          ),
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
                      getusercurrentposition().then((value) async {

                        setState(() {
                          latitude = value.latitude;
                          longitude = value.longitude;
                        });
                      });
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
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(latitude, longitude), zoom: 14.4746),
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          onMapCreated: (controller) async {
            loadmarker();
          },
          markers: <Marker>{
            Marker(
                icon: (markerimage == null)
                    ? BitmapDescriptor.defaultMarker
                    : BitmapDescriptor.fromBytes(markerimage!),
                markerId: const MarkerId("1"),
                position: LatLng(latitude, longitude),
                infoWindow: const InfoWindow(title: "User Location")),
          },
        ),
        drawer: HomeDrawer(username: widget.username, userid: widget.userid),
        bottomNavigationBar: DraggableScrollableSheet(
          initialChildSize: .4,
          minChildSize: .1,
          maxChildSize: .6,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(25),
                      child: Text(
                        "Set Destination",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: RiderDestinationSerachScreen(
                                  userid: widget.userid,
                                  username: widget.username,
                                )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 271,
                            height: 53,
                            child: TextField(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: RiderDestinationSerachScreen(
                                          userid: widget.userid,
                                          username: widget.username,
                                        )));
                              },
                              keyboardType: TextInputType.none,
                              controller: sourcelocation,
                              decoration: InputDecoration(
                                hintText: "Source Location",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none),
                                filled: true,
                                prefixIcon: Container(
                                  margin: const EdgeInsets.only(right: 9),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          width: 2,
                                          color: Colors.grey,
                                          strokeAlign: StrokeAlign.inside),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.circle,
                                    color: Colors.blue,
                                  ),
                                ),
                                suffixIcon: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ),
                                fillColor:
                                    const Color.fromARGB(255, 237, 237, 237),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: 271,
                            height: 53,
                            child: TextField(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: RiderDestinationSerachScreen(
                                          userid: widget.userid,
                                          username: widget.username,
                                        )));
                              },
                              keyboardType: TextInputType.none,
                              controller: destinationlocaton,
                              decoration: InputDecoration(
                                hintText: "Destination location",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none),
                                filled: true,
                                prefixIcon: Container(
                                  margin: const EdgeInsets.only(right: 9),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          width: 2,
                                          color: Colors.grey,
                                          strokeAlign: StrokeAlign.inside),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.blue,
                                  ),
                                ),
                                fillColor:
                                    const Color.fromARGB(255, 237, 237, 237),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
