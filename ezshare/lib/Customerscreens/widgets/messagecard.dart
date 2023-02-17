import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerMessageCard extends StatefulWidget {
  const CustomerMessageCard({super.key});

  @override
  State<CustomerMessageCard> createState() => _CustomerMessageCardState();
}

class _CustomerMessageCardState extends State<CustomerMessageCard> {
  @override
  Widget build(BuildContext context) {
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
                  Container(
                      margin: const EdgeInsets.only(left: 20, right: 10),
                      height: 33,
                      width: 41,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc=",
                        ),
                      )),
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      height: 46,
                      width: 264,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 173, 232, 251),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(0))),
                      child: Container(
                          margin: const EdgeInsets.only(top: 10, left: 10),
                          child: Text(
                            "I’m waiting for you",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.justify,
                          )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      height: 46,
                      width: 264,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 202, 242, 255),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(20))),
                      child: Container(
                          margin: const EdgeInsets.only(top: 10, left: 10),
                          child: Text(
                            "I’m on my way",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.justify,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 45,
            width: 360,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 202, 242, 255)),
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
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Colors.white)),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon:
                          const Icon(Icons.sentiment_satisfied_alt_outlined),
                      contentPadding: const EdgeInsets.all(0),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                ),
                InkWell(
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
          )
        ],
      ),
    );
  }
}
