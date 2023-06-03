import 'dart:convert';

import 'package:ezshare/Customerscreens/screens/customerrequestbooking.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../Providers/googlemapprovider.dart';
import '../../Riderscreens/screens/custommarker.dart';

class CustomerLocationSerachScreen extends StatefulWidget {
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
  const CustomerLocationSerachScreen(
      {super.key,
      required this.username,
      required this.userid,
      required this.imageurl,
      required this.cardid,
      required this.ridername,
      required this.vehiclemodel,
      required this.vehicleplatenumber,
      required this.seats,
      required this.time,
      required this.date,
      required this.startingpoint,
      required this.endpoint,
      required this.startlatlong,
      required this.endlatlong,
      required this.vehiclename,
      required this.userdata,
      required this.riderid});

  @override
  State<CustomerLocationSerachScreen> createState() =>
      _CustomerLocationSerachScreenState();
}

class _CustomerLocationSerachScreenState
    extends State<CustomerLocationSerachScreen> {
  List<dynamic> places = [];
  bool setloading = false;
  TextEditingController sourcelocation = TextEditingController();
  TextEditingController destinationlocation = TextEditingController();
  Uint8List? usermarkerstartimage, usermarkerendimage;
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
    final googlemapprovider = Provider.of<GoogleMapProvider>(context);
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
                      MaterialPageRoute(
                        builder: (context) => CustomerRequestBookingScreen(
                            username: widget.startingpoint,
                            userid: widget.userid,
                            imageurl: widget.imageurl,
                            cardid: widget.cardid,
                            ridername: widget.ridername,
                            vehiclemodel: widget.vehiclemodel,
                            vehicleplatenumber: widget.vehicleplatenumber,
                            seats: widget.seats,
                            time: widget.time,
                            date: widget.date,
                            startingpoint: widget.startingpoint,
                            endpoint: widget.endpoint,
                            startlatlong: widget.startlatlong,
                            endlatlong: widget.endlatlong,
                            vehiclename: widget.vehiclename,
                            userdata: widget.userdata,
                            riderid: widget.riderid),
                      ));
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
                        double startpointlat = 0.0,
                            startpointlong = 0.0,
                            endpointlat = 0.0,
                            endpointlong = 0.0;
                        List<Location> source = await locationFromAddress(
                            sourcelocation.text.toString());
                        List<Location> destination = await locationFromAddress(
                            destinationlocation.text.toString());
                        await CustomMarkerMaker()
                            .custommarkerfromasset(
                                "assets/images/startingpointmarker.png",
                                100,
                                100)
                            .then((value) => usermarkerstartimage = value);
                        await CustomMarkerMaker()
                            .custommarkerfromasset(
                                "assets/images/endpointmarker.png", 100, 100)
                            .then((value) => usermarkerendimage = value);
                        if (!googlemapprovider.pickup) {
                          googlemapprovider.markers.add(Marker(
                              icon: BitmapDescriptor.fromBytes(
                                  usermarkerstartimage!),
                              markerId: const MarkerId("4"),
                              position: LatLng(
                                  source.last.latitude, source.last.longitude),
                              infoWindow: const InfoWindow(
                                  title: "Customer Source Location")));

                          googlemapprovider.setStartingaddress(
                              sourcelocation.text.toString());
                          googlemapprovider.setpickup();
                        }
                        if (!googlemapprovider.dropoff) {
                          googlemapprovider.markers.add(Marker(
                              icon: BitmapDescriptor.fromBytes(
                                  usermarkerendimage!),
                              markerId: const MarkerId("5"),
                              position: LatLng(destination.last.latitude,
                                  destination.last.longitude),
                              infoWindow: const InfoWindow(
                                  title: "Customer Destination Location")));

                          googlemapprovider
                              .setEndaddress(destinationlocation.text);
                          googlemapprovider.setdropoff();

                          for (var element in googlemapprovider.markers) {
                            if (element.markerId.value == "4") {
                              startpointlat = element.position.latitude;
                              startpointlong = element.position.longitude;
                            }
                            if (element.markerId.value == "5") {
                              endpointlat = element.position.latitude;
                              endpointlong = element.position.longitude;
                            }
                          }

                          Map<String, dynamic> routeData = await fetchRouteData(
                              "AIzaSyCPVtwUwZEhuK351SVc9sZ_cwGYOOvcJJk",
                              startpointlat,
                              startpointlong,
                              endpointlat,
                              endpointlong);
                          googlemapprovider
                              .setDistance(getDistanceFromRoute(routeData));
                          googlemapprovider
                              .setTime(getTimeFromRoute(routeData));
                        }
                        // ignore: use_build_context_synchronously
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CustomerRequestBookingScreen(
                                      username: widget.startingpoint,
                                      userid: widget.userid,
                                      imageurl: widget.imageurl,
                                      cardid: widget.cardid,
                                      ridername: widget.ridername,
                                      vehiclemodel: widget.vehiclemodel,
                                      vehicleplatenumber:
                                          widget.vehicleplatenumber,
                                      seats: widget.seats,
                                      time: widget.time,
                                      date: widget.date,
                                      startingpoint: widget.startingpoint,
                                      endpoint: widget.endpoint,
                                      startlatlong: widget.startlatlong,
                                      endlatlong: widget.endlatlong,
                                      vehiclename: widget.vehiclename,
                                      userdata: widget.userdata,
                                      riderid: widget.riderid),
                            ));
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
