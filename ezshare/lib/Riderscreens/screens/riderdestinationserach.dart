import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ezshare/Riderscreens/screens/riderdestination.dart';
import 'package:ezshare/Riderscreens/screens/riderridecreateinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

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
  TextEditingController sourcelocation = TextEditingController();
  TextEditingController destinationlocation = TextEditingController();
  bool source = false,destination = false;
  @override
  initState() {
    super.initState();
  }

  placessearch(String address) async {
    Uri url = Uri.parse(
        "https://nominatim.openstreetmap.org/search?q=$address,karachi&format=json");
    final response = await http.get(url);
    setState(() {
      places = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        fillColor: const Color.fromARGB(255, 237, 237, 237),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                      ),
                      onChanged: (value) {
                        destination = false;
                        source = true;
                        if (sourcelocation.text.isNotEmpty) {
                          placessearch(sourcelocation.text);
                        }
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
                        suffixIcon: const Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                        fillColor: const Color.fromARGB(255, 237, 237, 237),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                      ),
                      onChanged: (value) {
                        source = false;
                        destination = true;
                        if (destinationlocation.text.isNotEmpty) {
                          placessearch(value);
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: RiderRideCreateInfoScreen(
                                  destinationlocation: destinationlocation.text,
                                  sourcelocation: sourcelocation.text,
                                  userid: widget.userid,
                                  username: widget.username,
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
                            child: Text(
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
                      String placeaddress = places[index]["display_name"];
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
                            if(source == true)
                            {

                            sourcelocation.text = placename.first;
                            }
                            else
                            {
                              destinationlocation.text = placename.first;
                            }
                          },
                          leading: const Icon(Icons.location_on_outlined),
                          title: Text(placename.first),
                          subtitle: Text(places[index]["display_name"]),
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
