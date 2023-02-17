import 'package:ezshare/Providers/ridecreateprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RiderRideSelectInfoCard extends StatefulWidget {
  const RiderRideSelectInfoCard({super.key});

  @override
  State<RiderRideSelectInfoCard> createState() => _RiderRideSelectInfoCardState();
}

class _RiderRideSelectInfoCardState extends State<RiderRideSelectInfoCard> {

  @override
  Widget build(BuildContext context) {
     final ridecreateprovider = Provider.of<RideCreateProvider>(context);
    return Container(
      height: double.infinity,
      color: const Color.fromARGB(126, 161, 159, 159),
      child: DraggableScrollableSheet(
        initialChildSize: .5,
        minChildSize: .1,
        maxChildSize: .6,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            margin: const EdgeInsets.only(bottom: 0, left: 0, right: 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.blue),
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Select  Vehicle",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        
                          if (ridecreateprovider.isClicked1 == false) {
                            // isSetvehicle = false;
                            ridecreateprovider.setVehicleFalse();
                            ridecreateprovider.setClick1();
                            // isClicked1 = true;
                            ridecreateprovider.setisVehicle("Bike");
                            // isVehicle = "Bike";
                            ridecreateprovider.setFalseClick2();
                            // isClicked2 = false;
                            ridecreateprovider.setFalseClick3();
                            // isClicked3 = false;
                          } else {
                           ridecreateprovider.setFalseClick1();
                            // isClicked1 = false;
                            ridecreateprovider.setFalseClick2();
                            // isClicked2 = false;
                            ridecreateprovider.setFalseClick3();
                            // isClicked3 = false;
                          }
                        
                      },
                      child: Container(
                        width: 96,
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: (ridecreateprovider.isClicked1 == false)
                                ? const Color.fromARGB(255, 233, 233, 235)
                                : const Color.fromARGB(255, 173, 232, 251)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/bike.png",
                              width: 74,
                              height: 53,
                            ),
                            Text(
                              "Bike",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "1 Seat",
                              style: GoogleFonts.poppins(
                                  color: Colors.blueAccent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                           

                          if ( ridecreateprovider.isClicked2 == false) {
                            // isSetvehicle = false;
                            ridecreateprovider.setVehicleFalse();
                             ridecreateprovider.setClick2();
                            // isClicked2 = true;
                             ridecreateprovider.setisVehicle("Car");
                            // isVehicle = "Car";
                             ridecreateprovider.setFalseClick1();
                            // isClicked1 = false;
                             ridecreateprovider.setFalseClick3();
                            // isClicked3 = false;
                          } else {
                            ridecreateprovider.setFalseClick1();
                            // isClicked1 = false;
                            ridecreateprovider.setFalseClick2();
                            // isClicked2 = false;
                            ridecreateprovider.setFalseClick3();
                            // isClicked3 = false;
                          }
                       
                      },
                      child: Container(
                        width: 96,
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: (ridecreateprovider.isClicked2 == false)
                                ? const Color.fromARGB(255, 233, 233, 235)
                                : const Color.fromARGB(255, 173, 232, 251)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/car.png",
                              width: 74,
                              height: 53,
                            ),
                            Text(
                              "Car",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "3 Seat",
                              style: GoogleFonts.poppins(
                                  color: Colors.blueAccent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        
                       
                          if (ridecreateprovider.isClicked3 == false) {
                            // isSetvehicle = false;
                            ridecreateprovider.setVehicleFalse();
                            ridecreateprovider.setClick3();
                            // isClicked3 = true;
                            ridecreateprovider.setisVehicle("SUV");
                            // isVehicle = "SUV";
                            ridecreateprovider.setFalseClick1();
                            // isClicked1 = false;
                            ridecreateprovider.setFalseClick2();
                            // isClicked2 = false;
                          } else {
                            ridecreateprovider.setFalseClick1();
                            // isClicked1 = false;
                            ridecreateprovider.setFalseClick2();
                            // isClicked2 = false;
                            ridecreateprovider.setFalseClick3();
                            // isClicked3 = false;
                          }
                        
                      },
                      child: Container(
                        width: 96,
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: (ridecreateprovider.isClicked3 == false)
                                ? const Color.fromARGB(255, 233, 233, 235)
                                : const Color.fromARGB(255, 173, 232, 251)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/suv.png",
                              width: 74,
                              height: 53,
                            ),
                            Text(
                              "SUV",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "4 Seat",
                              style: GoogleFonts.poppins(
                                  color: Colors.blueAccent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}