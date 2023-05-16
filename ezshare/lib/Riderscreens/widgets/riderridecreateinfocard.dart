import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Providers/ridecreateprovider.dart';
import 'package:ezshare/Riderscreens/screens/riderdestination.dart';
import 'package:ezshare/successlogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class RiderRiderCreateInfoCard extends StatefulWidget {
  final String userid;
  final String username;
  final double distance;
  final int time;
  const RiderRiderCreateInfoCard(
      {super.key, required this.userid, required this.username, required this.distance, required this.time,});

  @override
  State<RiderRiderCreateInfoCard> createState() =>
      _RiderRiderCreateInfoCardState();
}

class _RiderRiderCreateInfoCardState extends State<RiderRiderCreateInfoCard> {
  bool setLoading = false;
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  String imageurl = "";
  riderridedetailsadd(String image,
      String vehiclename, String vehiclenumber, String isVehicle,String source,String destination) async {
    await rides.add({
      "imageurl" : image,
      "users": {},
      "Rider Contact": SuccessPage.user!.phoneNumber,
      "Ridername": widget.username,
      "Riderid": widget.userid,
      "Time": widget.time.toString(),
      "Distance": widget.distance.toString(),
      "Vehicle": isVehicle,
      "Seats": count, 
      "Rating": 0,
      "VehicleName": vehiclename,
      "VehicleNumber": vehiclenumber,
      "SelectedDate": formattedDate,
      "SelectedTime": selectedtime, 
      "SourceLocation": source,
      "DestinationLocation": destination,
    });
  }

  TextEditingController vehiclename = TextEditingController();
  TextEditingController vehiclenumber = TextEditingController();
  int count = 1;
  DateTime? pickedDate;
  String formattedDate = "";
  TimeOfDay? time;
  String selectedtime = "";
  @override
  Widget build(BuildContext context) {
    final ridecreateprovider = Provider.of<RideCreateProvider>(context);
    return DraggableScrollableSheet(
      initialChildSize: (ridecreateprovider.isVehicle.isEmpty) ? .4 : .6,
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
            child: Column(children: [
              Container(
                height: 110,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.blue),
                margin: const EdgeInsets.all(0),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.circle, color: Colors.white),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            ridecreateprovider.sourcelocation,softWrap: true,
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.location_on_outlined,
                            color: Colors.white),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            ridecreateprovider.destinationlocation,
                            style: GoogleFonts.poppins(color: Colors.white),softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Estimated Time",
                        style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 155, 155, 155)),
                      ),
                      Text(
                        "${widget.time} min",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        "Total Kilometer",
                        style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 155, 155, 155)),
                      ),
                      Text(
                        "${widget.distance} Km",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          ridecreateprovider.setVehicle();
                        });
                      },
                      hoverColor: Colors.white,
                      child: Container(
                          margin: EdgeInsets.only(
                              top: 20,
                              right: (ridecreateprovider.isVehicle.isEmpty)
                                  ? 80
                                  : 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blue, width: 1)),
                          width: 105,
                          height: 39,
                          child: Center(
                            child: Text(
                              (ridecreateprovider.isVehicle.isEmpty)
                                  ? "Select Vehicle"
                                  : ridecreateprovider.isVehicle,
                              style: GoogleFonts.poppins(
                                  fontSize: 13, color: Colors.blue),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ),
                    (ridecreateprovider.isVehicle.isNotEmpty)
                        ? Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 155, 155, 155),
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4))),
                                      child: InkWell(
                                        onTap: () {
                                          if (ridecreateprovider.isVehicle
                                              .contains("Bike")) {
                                            setState(() {
                                              if (count < 1) {
                                                count++;
                                              }
                                            });
                                          } else if (ridecreateprovider
                                              .isVehicle
                                              .contains("Car")) {
                                            setState(() {
                                              if (count < 3) {
                                                count++;
                                              }
                                            });
                                          }
                                          if (ridecreateprovider.isVehicle
                                              .contains("SUV")) {
                                            setState(() {
                                              if (count < 5) {
                                                count++;
                                              }
                                            });
                                          }
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 22,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 155, 155, 155))),
                                      child: Center(
                                        child: Text("$count",
                                            style: GoogleFonts.poppins(
                                                fontSize: 12),
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 155, 155, 155),
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4))),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (count > 1) {
                                              count--;
                                            }
                                          });
                                        },
                                        child: const Icon(
                                          CupertinoIcons.minus,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text("Passenger",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: const Color.fromARGB(
                                            255, 155, 155, 155),
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              (ridecreateprovider.isVehicle.isNotEmpty)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 24,
                          child: TextField(
                            onTap: () {
                              showModalBottomSheet( shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(10))),
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 400,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(10))),
                                          padding: const EdgeInsets.all(5.0),
                                          child: TextField(
                                            controller: vehiclename,
                                            maxLines: null,
                                            autofocus: true,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 1),
                                              hintText: "Vehicle Name",
                                              hintStyle: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: BorderSide.none),
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  255, 237, 237, 237),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide.none),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Close"))
                                      ],
                                    ),
                                  );
                                },
                              );
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            autofocus: false,
                            controller: vehiclename,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 1),
                              hintText: "Vehicle Name",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 10, fontWeight: FontWeight.w600),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 237, 237, 237),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          height: 24,
                          child: TextField(
                            onTap: () {
                              showModalBottomSheet( shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(10))),
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 400,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(10))),
                                          padding: const EdgeInsets.all(5.0),
                                          child: TextField(
                                            controller: vehiclenumber,
                                            maxLines: null,
                                            autofocus: true,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 1),
                                              hintText: "Vehicle Number",
                                              hintStyle: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  borderSide: BorderSide.none),
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  255, 237, 237, 237),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide.none),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Close"))
                                      ],
                                    ),
                                  );
                                },
                              );
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            controller: vehiclenumber,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 1),
                              hintText: "Vehicle Number",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 10, fontWeight: FontWeight.w600),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 237, 237, 237),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(),
              const SizedBox(
                height: 10,
              ),
              (ridecreateprovider.isVehicle.isNotEmpty)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), //get today's date
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              setState(() {
                                formattedDate = DateFormat('yyyy-MM-dd')
                                    .format(pickedDate!);
                              });
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          },
                          child: Container(
                              margin: const EdgeInsets.only(top: 10, right: 0),
                              decoration: BoxDecoration(
                                  color: (formattedDate.isNotEmpty)
                                      ? Colors.white
                                      : Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: Colors.blue, width: 1)),
                              width: 75,
                              height: 45,
                              child: Center(
                                child: (formattedDate.isEmpty)
                                    ? Text(
                                        "Select Date",
                                        style: GoogleFonts.poppins(
                                            fontSize: 10, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      )
                                    : Text(
                                        formattedDate,
                                        style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: Colors.blueAccent),
                                        textAlign: TextAlign.center,
                                      ),
                              )),
                        ),
                        InkWell(
                          onTap: () async {
                            time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            setState(() {
                              selectedtime = time!.format(context);
                            });

                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: Container(
                              margin: const EdgeInsets.only(top: 10, right: 0),
                              decoration: BoxDecoration(
                                  color: (selectedtime.isNotEmpty)
                                      ? Colors.white
                                      : Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: Colors.blue, width: 1)),
                              width: 75,
                              height: 45,
                              child: Center(
                                child: (selectedtime.isEmpty)
                                    ? Text(
                                        "Select Time",
                                        style: GoogleFonts.poppins(
                                            fontSize: 10, color: Colors.white),
                                        textAlign: TextAlign.center,
                                      )
                                    : Text(
                                        selectedtime,
                                        style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: Colors.blueAccent),
                                        textAlign: TextAlign.center,
                                      ),
                              )),
                        )
                      ],
                    )
                  : Row(),
              const SizedBox(
                height: 20,
              ),
              (ridecreateprovider.isVehicle.isNotEmpty)
                  ? InkWell(
                      onTap: () async  { setState(() {
                        setLoading = true;
                      }); 
                      await users.doc(widget.userid).get().then((value) {
                        try {
                          imageurl = value["imageurl"];
                        } catch (e) {
                          imageurl = "";
                        }
                       } 
                       
                       );


                        await riderridedetailsadd(imageurl,vehiclename.text,vehiclenumber.text,ridecreateprovider.isVehicle,ridecreateprovider.sourcelocation,ridecreateprovider.destinationlocation);
                         setState(() {
                           
                         setLoading = false;
                         });
                        // ignore: use_build_context_synchronously
                            Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child:
                        RiderDestinationSetScreen(
                         userid: widget.userid, username: widget.username,)  ));
                      },
                      child: Container(
                          margin: const EdgeInsets.only(top: 10, right: 0),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.blue, width: 1)),
                          width: 256,
                          height: 44,
                          child: Center(
                            child: (setLoading)? const CircularProgressIndicator(color: Colors.white) : Text(
                              "Create Ride",
                              style: GoogleFonts.poppins(
                                  fontSize: 13, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    )
                  : const Center()
            ]),
          ),
        );
      },
    );
  }
}
