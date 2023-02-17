import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RideStartCard extends StatefulWidget {
  const RideStartCard({super.key});

  @override
  State<RideStartCard> createState() => _RideStartCardState();
}

class _RideStartCardState extends State<RideStartCard> {
  
  @override
  Widget build(BuildContext context) {
   
   
    return Container(
      margin: const EdgeInsets.all(15),
      width: 300,
      height: 430,
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
                    width: 69,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc=",
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
                                "Rider Name",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              )),
                              SizedBox(
                                  child: Text(
                                "Time: 5min",
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
                                  onTap: () {
                                     
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
                                  onTap: () {},
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
                        margin: const EdgeInsets.only(bottom: 7),
                        child: const Text(
                          "Saddar,Karachi",
                          style: TextStyle(
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
                      const Text(
                        "Hussainabad,Karachi",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.grey),
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
                            margin: const EdgeInsets.only(top: 0, bottom: 2),
                            child: const Text(
                              "Pick-up Location",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 7),
                            child: const Text(
                              "Saddar,Karachi",
                              style: TextStyle(
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
                                margin: const EdgeInsets.only(top: 0, bottom: 2),
                                child: const Text(
                                  "Drop-Off Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ),
                              const SizedBox(
                                child: Text(
                                  "Hussainabad,Karachi",
                                  style: TextStyle(
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
                  "Seat Capacity",
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                  ),
                ),
                Text("1",
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
                Text("KBR-9050",
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
                  "Available Seat",
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                  ),
                ),
                Text("1",
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
            child: Container(
              height: 26,
              width: 106,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.blue,
              ),
              child: InkWell(
                onTap: () {
                  //  Navigator.push(
                  // context,
                  // MaterialPageRoute(
                  //   builder: (context) => const  RiderRideDetailViewScreen(userid: '', username: '',),
                  // ));
                },
                child: Center(
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white,fontSize: 15),
                      )),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}