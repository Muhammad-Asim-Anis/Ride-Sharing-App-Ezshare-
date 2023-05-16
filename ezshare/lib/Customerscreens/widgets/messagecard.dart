import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Providers/messageprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomerMessageCard extends StatefulWidget {
  final String senderid;
  final String username;
  final String imageurl;
  final String reciverid;
  const CustomerMessageCard(
      {super.key,
      required this.senderid,
      required this.username,
      required this.imageurl,
      required this.reciverid});

  @override
  State<CustomerMessageCard> createState() => _CustomerMessageCardState();
}

class _CustomerMessageCardState extends State<CustomerMessageCard> {
  CollectionReference chats = FirebaseFirestore.instance.collection("Chats");
  int flexvalue = 0;
  TextEditingController messagecontroller = TextEditingController();
 

  @override
  void initState() {
    super.initState();
   
  }
  

  @override
  Widget build(BuildContext context) {
    final messageprovider = Provider.of<MessageCardProvider>(context);
    return Container(
      width: 360,
      height: 525,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: .5,
            )
          ]),
      child: Column(
        children: [
          Material(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40)),
            elevation: 4,
            child: Container(
              margin: const EdgeInsets.all(12),
              height: 41,
              width: 360,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      messageprovider.setClickFalse();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(0),
                      height: 31,
                      width: 31,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 10),
                    height: 33,
                    width: 41,
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
                              color: Colors.blue,
                              size: 40,
                            ),
                          ),
                  ),
                  SizedBox(
                      child: Text(
                    "Rider Name",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  )),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: chats
                  .doc(messageprovider.roomid)
                  .collection("messages")
                  .orderBy("TimeStamp", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot chatdetails =
                        snapshot.data!.docs[index];
                    return Align(
                      alignment: (chatdetails['sentby'] == widget.senderid)
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        height: 46,
                        width: 264,
                        decoration: (chatdetails['sentby'] == widget.senderid)
                            ? const BoxDecoration(
                                color: Color.fromARGB(255, 173, 232, 251),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(0)))
                            : const BoxDecoration(
                                color: Color.fromARGB(255, 202, 242, 255),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(20))),
                        child: Container(
                            margin: const EdgeInsets.only(top: 10, left: 10),
                            child: Text(
                              chatdetails["msg"],
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.justify,
                            )),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Flexible(
            flex: flexvalue,
            child: Container(
              height: 45,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 202, 242, 255)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 31,
                    width: 256,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white),
                    child: TextField( 
                      onTap: () { 
                        setState(() {
                          flexvalue = 3;
                        });
                      },
                      onEditingComplete: () {
                        setState(() {
                          flexvalue = 0;
                        });

                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      controller: messagecontroller,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.white)),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon:
                            const Icon(Icons.sentiment_satisfied_alt_outlined),
                        contentPadding: const EdgeInsets.all(0),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (messagecontroller.text.isNotEmpty) {
                        await chats
                            .doc(messageprovider.roomid)
                            .collection("messages")
                            .add({
                          "sentby": widget.senderid,
                          "msg": messagecontroller.text.toString(),
                          "TimeStamp": DateTime.now(),
                        });
                      }

                      // messageprovider.deleteRoomId();
                      messagecontroller.clear();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(0),
                      height: 31,
                      width: 31,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(100)),
                      child: Transform.rotate(
                          angle: 12,
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
