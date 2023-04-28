import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ezshare/Riderscreens/screens/riderdestination.dart';
import 'package:ezshare/Riderscreens/screens/riderridecreateinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../Providers/ridecreateprovider.dart';

class RiderDestinationSerachScreen extends StatefulWidget {
  final String username;
  final String userid;
  const RiderDestinationSerachScreen(
      {super.key, required this.username, required this.userid});

  @override
  State<RiderDestinationSerachScreen> createState() =>
      _RiderDestinationSerachScreenState();
}

class _RiderDestinationSerachScreenState
    extends State<RiderDestinationSerachScreen> {
  List<dynamic> places = [];
  bool setloading = false;
  TextEditingController sourcelocation =
      TextEditingController(text: RiderRideCreateInfoScreen.sourcelocat);
  TextEditingController destinationlocation =
      TextEditingController(text: RiderRideCreateInfoScreen.destinationlocat);
  bool source = false, destination = false;
  var uuid = const Uuid();
  String _sessiontoken = "122344";
  @override
  initState() {
    super.initState();
    onChange();
  }

  void onChange() {
    // ignore: unnecessary_null_comparison
    if (_sessiontoken == null) {
      setState(() {
        _sessiontoken = uuid.v4();
      });
    }
  }

  placessearch(String address) async {
    String placesapi = "AIzaSyCPVtwUwZEhuK351SVc9sZ_cwGYOOvcJJk";
    String baseurl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request =
        "$baseurl?input=${address}karachi&key=$placesapi&sessiontoken=$_sessiontoken";

    Uri url = Uri.parse(request);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        places = jsonDecode(response.body)["predictions"];
      });
    } else {}
  }

  Future<Map<String, dynamic>> fetchRouteData(String apiKey, double startLat,
      double startLng, double endLat, double endLng) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$startLat,$startLng&destination=$endLat,$endLng&key=$apiKey";
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch route data');
    }
  }

  double getDistanceFromRoute(Map<String, dynamic> routeData) {
    int distanceInMeters =
        routeData['routes'][0]['legs'][0]['distance']['value'];
    double distanceInKilometers = distanceInMeters / 1000;
    return distanceInKilometers;
  }

  int getTimeFromRoute(Map<String, dynamic> routeData) {
    int timeInSeconds = routeData['routes'][0]['legs'][0]['duration']['value'];
    return timeInSeconds;
  }

  @override
  Widget build(BuildContext context) {
    final ridecreateprovider = Provider.of<RideCreateProvider>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 237, 237),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
                          child: RiderDestinationSetScreen(
                            userid: widget.userid,
                            username: widget.username,
                          )));
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              width: 360,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 271,
                    height: 53,
                    child: TextField(
                      controller: sourcelocation,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5),
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
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              sourcelocation.clear();
                              places = [];
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: const Color.fromARGB(255, 237, 237, 237),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                      ),
                      onChanged: (value) async {
                        destination = false;
                        source = true;
                        await placessearch(sourcelocation.text);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                  SizedBox(
                    width: 271,
                    height: 53,
                    child: TextField(
                      controller: destinationlocation,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5),
                        hintText: "Destination Location",
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
                            Icons.location_on_outlined,
                            color: Colors.blue,
                          ),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              sourcelocation.clear();
                              places = [];
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: const Color.fromARGB(255, 237, 237, 237),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                      ),
                      onChanged: (value) async {
                        source = false;
                        destination = true;
                        await placessearch(destinationlocation.text);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () async {
                        List<LatLng> polylines = [];
                        GoogleMapPolyline googleMapPolyline = GoogleMapPolyline(
                            apiKey: "AIzaSyCPVtwUwZEhuK351SVc9sZ_cwGYOOvcJJk");

                        setloading = true;
                        ridecreateprovider
                            .setSourceLocation(sourcelocation.text.toString());
                        ridecreateprovider.setDestinationLocation(
                            destinationlocation.text.toString());
                        List<Location> locationssource =
                            await locationFromAddress(
                                sourcelocation.text.toString());

                        List<Location> locationsdestination =
                            await locationFromAddress(
                                destinationlocation.text.toString());

                        polylines =
                            (await googleMapPolyline.getCoordinatesWithLocation(
                          origin: LatLng(locationssource.last.latitude,
                              locationssource.last.longitude),
                          destination: LatLng(
                              locationsdestination.last.latitude,
                              locationsdestination.last.longitude),
                          mode: RouteMode.driving,
                        ))!;

                        Map<String, dynamic> routeData = await fetchRouteData(
                            "AIzaSyCPVtwUwZEhuK351SVc9sZ_cwGYOOvcJJk",
                            locationssource.last.latitude,
                            locationssource.last.longitude,
                            locationsdestination.last.latitude,
                            locationsdestination.last.longitude);

                        double distance = getDistanceFromRoute(routeData);
                        double time = getTimeFromRoute(routeData) / 60;

                        setloading = false;
                        // ignore: use_build_context_synchronously
                        await Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: RiderRideCreateInfoScreen(
                                  destinationlocation: destinationlocation.text,
                                  sourcelocation: sourcelocation.text,
                                  userid: widget.userid,
                                  username: widget.username,
                                  destinationlist: locationsdestination,
                                  sourcelist: locationssource,
                                  polylines: polylines, distance: distance.ceilToDouble(), time: time.round(),
                                )));
                      },
                      hoverColor: Colors.white,
                      child: Center(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.blue, width: 1)),
                            width: 200,
                            child: (setloading)
                                ? const Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))
                                : Text(
                                    "Confirm",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      if (places.isEmpty) {
                        return Container();
                      }
                      String placeaddress = places[index]["description"];
                      var placename = placeaddress.split(',');
                      return Container(
                        margin: const EdgeInsets.all(0),
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 2,
                                color: Colors.grey,
                                strokeAlign: StrokeAlign.inside),
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            if (source == true) {
                              sourcelocation.text = placename.first;
                            } else {
                              destinationlocation.text = placename.first;
                            }
                          },
                          leading: const Icon(Icons.location_on_outlined),
                          title: Text(placename.first),
                          subtitle: Text(places[index]["description"]),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
