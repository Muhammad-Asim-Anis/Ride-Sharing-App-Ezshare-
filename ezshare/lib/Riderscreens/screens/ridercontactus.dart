
import 'package:ezshare/homedrawer.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderContactUsScreen extends StatefulWidget {
  final String userid;
  final String username;
  const RiderContactUsScreen(
      {super.key, required this.userid, required this.username});

  @override
  State<RiderContactUsScreen> createState() => _RiderContactUsScreenState();
}

class _RiderContactUsScreenState extends State<RiderContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blue, size: 40),
        title: Text(
          "Contact Us",
          style: GoogleFonts.poppins(
              color: Colors.blueAccent,
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 0, top: 20),
              width: 136,
              height: 136,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.blueAccent),
              child: const Icon(
                Icons.phone,
                color: Colors.white,
                size: 60,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              child: Text(
                "Call",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      drawer:
          HomeDrawer(username: widget.username, userid: widget.userid),
    );
  }
}
