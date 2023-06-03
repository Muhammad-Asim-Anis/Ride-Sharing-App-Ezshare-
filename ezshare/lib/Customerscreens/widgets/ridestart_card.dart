import 'package:ezshare/Providers/messageprovider.dart';
import 'package:ezshare/Riderscreens/screens/ridercanceltrip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RideStartCard extends StatefulWidget {
  final String userid;
  final String username;
  final String ridername;
  final String vehiclemodel;
  final String vehicleplatenumber;
  final int seats;
  final String time;
  final String date;
  final String startingpoint;
  final String endpoint;
  final String rideid;
  final String imageurl;
  final String vehiclename;
  final String userstartpoint;
  final String userendpoint;
  final String riderid;
  const RideStartCard(
      {super.key,
      required this.userid,
      required this.username,
      required this.ridername,
      required this.vehiclemodel,
      required this.vehicleplatenumber,
      required this.seats,
      required this.time,
      required this.date,
      required this.startingpoint,
      required this.endpoint,
      required this.rideid,
      required this.imageurl,
      required this.vehiclename,
      required this.userstartpoint,
      required this.userendpoint,
      required this.riderid});

  @override
  State<RideStartCard> createState() => _RideStartCardState();
}

class _RideStartCardState extends State<RideStartCard> {
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
  CollectionReference chats = FirebaseFirestore.instance.collection("Chats");
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  String roomid = "";
  bool isarrived = false, isstart = false, isridestart = false;
  @override
  void initState() {
    super.initState();
    ridestartcheck();
    riderarrivedcheck();
    rideafterstartcheck();
  }

  createchatroom() async {
    QuerySnapshot snapshot = await chats
        .where("participants.${widget.userid}", isEqualTo: true)
        .where("participants.${widget.riderid}", isEqualTo: true)
        .get();
    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        roomid = element.id;
      }
    } else {
      await chats.doc("${widget.userid}${widget.riderid}").set({
        "Senderid": widget.userid,
        "Reciverid": widget.riderid,
        "participants": {widget.userid: true, widget.riderid: true}
      });
      roomid = "${widget.userid}${widget.riderid}";
    }
  }

  ridestartcheck() {
    rides.doc(widget.rideid).snapshots().listen((event) {
     
      setState(() {
        try {
          isridestart = event["ridestart"];
        } catch (e) {
          isridestart = false;
        }
      });
    });
  }

  riderarrivedcheck() {
    rides.doc(widget.rideid).snapshots().listen((event) {
      Map<String, dynamic> users = event["users"];
      setState(() {
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

  rideafterstartcheck() {
    rides.doc(widget.rideid).snapshots().listen((event) {
      Map<String, dynamic> users = event["users"];
      setState(() {
        try {
          isstart = users.entries
              .firstWhere((element) => element.key == widget.userid)
              .value["start"];
        } catch (e) {
          isstart = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final messageprovider = Provider.of<MessageCardProvider>(context);

    return Container(
      margin: const EdgeInsets.all(15),
      width: 300,
      height: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: .5,
            )
          ]),
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7), topRight: Radius.circular(7)),
                color: Colors.blue),
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.all(0),
                    height: 57,
                    width: 68,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: (widget.imageurl.isNotEmpty)
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.imageurl,
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(
                              CupertinoIcons.person_circle,
                              color: Colors.white,
                              size: 70,
                            ),
                          )),
                Container(
                  margin: const EdgeInsets.only(left: 0, top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection: TextDirection.ltr,
                            children: [
                              SizedBox(
                                  child: Text(
                                widget.ridername,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              )),
                              SizedBox(
                                  child: Text(
                                "Time: ${widget.time}",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              )),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await createchatroom();

                                    messageprovider.setRoomId(roomid);

                                    messageprovider.setItemCount(1);
                                    messageprovider.setClick();
                                  },
                                  child: Container(
                                      width: 39,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          boxShadow: const [
                                            BoxShadow(
                                              color:
                                                  Color.fromARGB(50, 0, 0, 0),
                                              spreadRadius: 0,
                                              blurRadius: 4,
                                              offset: Offset(0, 4),
                                            )
                                          ]),
                                      child: const Icon(
                                        Icons.message_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      )),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () async {
                                    String number = "";
                                    await users
                                        .doc(widget.riderid)
                                        .get()
                                        .then((value) {
                                      number = value["id"];
                                    });
                                    Uri phoneno = Uri.parse("tel:$number");
                                    await launchUrl(phoneno);
                                  },
                                  child: Container(
                                      width: 39,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          boxShadow: const [
                                            BoxShadow(
                                              color:
                                                  Color.fromARGB(50, 0, 0, 0),
                                              spreadRadius: 0,
                                              blurRadius: 4,
                                              offset: Offset(0, 4),
                                            )
                                          ]),
                                      child: const Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                        size: 20,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.circle,
                        color: Colors.red,
                        size: 17,
                      ),
                      Icon(
                        Icons.arrow_circle_down,
                        size: 10,
                      ),
                      Icon(
                        Icons.arrow_circle_down,
                        size: 10,
                      ),
                      Icon(
                        Icons.arrow_circle_down,
                        size: 10,
                      ),
                      Icon(
                        Icons.location_on,
                        size: 17,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 0, bottom: 2),
                        child: const Text(
                          "Starting point",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 10,
                        margin: const EdgeInsets.only(bottom: 7),
                        child: Text(
                          widget.startingpoint,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.grey),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 0, bottom: 2),
                        child: const Text(
                          "Ending point",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 10,
                        margin: const EdgeInsets.only(bottom: 0),
                        child: Text(
                          widget.endpoint,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10),
            child: SizedBox(
              height: 1.0,
              child: Container(
                margin: const EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                height: 1.0,
                width: 300,
                color: Colors.blue,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.circle,
                        color: Colors.red,
                        size: 17,
                      ),
                      Icon(
                        Icons.arrow_circle_down,
                        size: 10,
                      ),
                      Icon(
                        Icons.arrow_circle_down,
                        size: 10,
                      ),
                      Icon(
                        Icons.arrow_circle_down,
                        size: 10,
                      ),
                      Icon(
                        Icons.location_on,
                        size: 17,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 280,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 0, bottom: 2),
                                child: const Text(
                                  "Pick-up Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                              Container(
                                width: 200,
                                height: 10,
                                margin: const EdgeInsets.only(bottom: 7),
                                child: Text(
                                  widget.userstartpoint,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      child: SizedBox(
                        height: 1.0,
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(
                              start: 1.0, end: 1.0),
                          height: 1.0,
                          width: 279,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 280,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 0, bottom: 2),
                                child: const Text(
                                  "Drop-Off Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                height: 10,
                                child: Text(
                                  widget.userendpoint,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10),
            child: SizedBox(
              height: 1.0,
              child: Container(
                margin: const EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                height: 1.0,
                width: 300,
                color: Colors.blue,
              ),
            ),
          ),
          Container(
            width: 286,
            margin: const EdgeInsets.only(left: 0, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Seat Booked",
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                  ),
                ),
                Text("${widget.seats}",
                    style: GoogleFonts.poppins(
                      fontSize: 9,
                    ))
              ],
            ),
          ),
          Container(
            width: 286,
            margin: const EdgeInsets.only(left: 0, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Plate-Number",
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                  ),
                ),
                Text(widget.vehicleplatenumber,
                    style: GoogleFonts.poppins(
                      fontSize: 9,
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: (isstart == false)
                ? Container(
                    height: 26,
                    width: 106,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.blue,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RiderCancelTripScreen(
                                arrived: isarrived,
                                  ridestart: isridestart,
                                  date: widget.date,
                                  endpoint: widget.endpoint,
                                  imageurl: widget.imageurl,
                                  rideid: widget.rideid,
                                  riderid: widget.riderid,
                                  ridername: widget.ridername,
                                  seats: widget.seats,
                                  startingpoint: widget.startingpoint,
                                  time: widget.time,
                                  userendpoint: widget.userendpoint,
                                  userid: widget.userid,
                                  username: widget.username,
                                  userstartpoint: widget.userstartpoint,
                                  vehiclemodel: widget.vehiclemodel,
                                  vehiclename: widget.vehiclename,
                                  vehicleplatenumber:
                                      widget.vehicleplatenumber),
                            ));
                      },
                      child: Center(
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "Cancel",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )),
                      ),
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
