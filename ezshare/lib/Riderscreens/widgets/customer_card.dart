// ignore_for_file: avoid_unnecessary_containers
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Providers/messageprovider.dart';

class CustomerBookCard extends StatefulWidget {
  final String customername;
  final String vehiclemodel;
  final int seats;
  final String time;
  final String date;
  final String startingpoint;
  final String endpoint;
  final String senderid;
  final String receiveid;
  final String imageurl;
  final String usercontact;
  final String rideid;
  final bool afterstart;
  const CustomerBookCard(
      {super.key,
      required this.customername,
      required this.vehiclemodel,
      required this.seats,
      required this.time,
      required this.date,
      required this.startingpoint,
      required this.endpoint,
      required this.senderid,
      required this.receiveid,
      required this.imageurl,
      required this.usercontact,
      required this.rideid,
      required this.afterstart});

  @override
  State<CustomerBookCard> createState() => _CustomerBookCardState();
}

class _CustomerBookCardState extends State<CustomerBookCard> {
  CollectionReference rides = FirebaseFirestore.instance.collection("Rides");
  CollectionReference chats = FirebaseFirestore.instance.collection("Chats");
  String roomid = "";
  bool isarrived = false, isstart = false;
  bool isaccept = false;
  @override
  void initState() {
    super.initState();
    ridearrivedcheck();
    ridestartcheck();
  }

  createchatroom() async {
    QuerySnapshot snapshot = await chats
        .where("participants.${widget.senderid}", isEqualTo: true)
        .where("participants.${widget.receiveid}", isEqualTo: true)
        .get();
    if (snapshot.docs.isNotEmpty) {
      for (var element in snapshot.docs) {
        roomid = element.id;
      }
    } else {
      await chats.doc("${widget.senderid}${widget.receiveid}").set({
        "Senderid": widget.senderid,
        "Reciverid": widget.receiveid,
        "participants": {widget.senderid: true, widget.receiveid: true}
      });
      roomid = "${widget.senderid}${widget.receiveid}";
    }
  }

  ridearrivedcheck() {
    rides.doc(widget.rideid).snapshots().listen((event) {
      Map<String, dynamic> users = event["users"];
      setState(() {
        try {
          isarrived = users.entries
              .firstWhere((element) => element.key == widget.receiveid)
              .value["arrived"];
        } catch (e) {
          isarrived = false;
        }
      });
    });
  }

  ridestartcheck() {
    rides.doc(widget.rideid).snapshots().listen((event) {
      Map<String, dynamic> users = event["users"];
      setState(() {
        try {
          isstart = users.entries
              .firstWhere((element) => element.key == widget.receiveid)
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
      height: 300,
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
            height: 79,
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
                  height: 50,
                  width: 47,
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
                            size: 50,
                          ),
                        ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                        widget.customername,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      )),
                      const SizedBox(
                        height: 0,
                      ),
                      Container(
                          child: Row(
                        children: [
                          Text(
                            "Time: ${widget.time}",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
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
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromARGB(50, 0, 0, 0),
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
                              Uri phoneno =
                                  Uri.parse("tel:${widget.usercontact}");
                              await launchUrl(phoneno);
                            },
                            child: Container(
                                width: 39,
                                height: 30,
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
                                child: const Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 20,
                                )),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 2),
                      child: const Text(
                        "Customer Pick-up Location",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 10,
                      margin: const EdgeInsets.only(bottom: 0),
                      child: Text(
                        widget.startingpoint,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                      child: Center(
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(
                              start: 1.0, end: 1.0),
                          height: 1.0,
                          width: 230,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 2),
                      child: const Text(
                        "Customer Drop-Off Location",
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
          Container(
            margin: const EdgeInsets.only(left: 25, top: 10),
            child: SizedBox(
              height: 1.0,
              child: Container(
                margin: const EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                height: 1.0,
                width: 270,
                color: Colors.blue,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 25, top: 10, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Seat Booked: ",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                  ),
                ),
                Text(
                  "1",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          (widget.afterstart == false)
              ? Row(
                  mainAxisAlignment: (isstart)
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceAround,
                  children: [
                    (isarrived == false)
                        ? Container(
                            height: 33,
                            width: 106,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.blue,
                            ),
                            child: InkWell(
                              onTap: () {
                                rides.doc(widget.rideid).update({
                                  "users.${widget.receiveid}.arrived": true,
                                });
                              },
                              child: Center(
                                child: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Arrived",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                          )
                        : (isstart == false)
                            ? Container(
                                height: 33,
                                width: 106,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.blue,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    rides.doc(widget.rideid).update({
                                      "users.${widget.receiveid}.start": true,
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Start",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ),
                              )
                            : Container(
                                height: 33,
                                width: 106,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.blue,
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "End",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ),
                              ),
                    (isstart == false)
                        ? Container(
                            height: 33,
                            width: 106,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.blue,
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                child: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Cencel",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                )
              : (isaccept == false)? Row(
                  mainAxisAlignment: (isstart)
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 33,
                      width: 106,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.blue,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            
                          isaccept = true;
                          });
                        },
                        child: Center(
                          child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "Accept",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                    ),
                    Container(
                      height: 33,
                      width: 106,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.blue,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "Reject",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                    )
                  ],
                ) : Row(
                  mainAxisAlignment: (isstart)
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceAround,
                  children: [
                    (isarrived == false)
                        ? Container(
                            height: 33,
                            width: 106,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.blue,
                            ),
                            child: InkWell(
                              onTap: () {
                                rides.doc(widget.rideid).update({
                                  "users.${widget.receiveid}.arrived": true,
                                });
                              },
                              child: Center(
                                child: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Arrived",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                          )
                        : (isstart == false)
                            ? Container(
                                height: 33,
                                width: 106,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.blue,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    rides.doc(widget.rideid).update({
                                      "users.${widget.receiveid}.start": true,
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "Start",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ),
                              )
                            : Container(
                                height: 33,
                                width: 106,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.blue,
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Center(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "End",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ),
                              ),
                    (isstart == false)
                        ? Container(
                            height: 33,
                            width: 106,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.blue,
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                child: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Cencel",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                )
        ],
      ),
    );
  }
}
