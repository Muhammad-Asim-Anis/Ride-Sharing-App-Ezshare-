// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CanceledRideCard extends StatefulWidget {
 final String cancelby;
 
   final String startingpoint;
  final String endpoint;
  final String timeafter;
  final String dateafter;
  const CanceledRideCard({super.key, required this.cancelby, required this.startingpoint, required this.endpoint, required this.timeafter, required this.dateafter});

  @override
  State<CanceledRideCard> createState() => _CanceledRideCardState();
}

class _CanceledRideCardState extends State<CanceledRideCard> {
  String formatDate(String inputDate) {
  DateTime date = DateTime.parse(inputDate);
  String formattedDate = DateFormat.MMMM().format(date); // Get the full month name
  int day = date.day;

  return '$formattedDate $day';
}
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140, width: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 206, 206, 206),
              blurRadius: 5.0,
              spreadRadius: .1,
            )
          ]),
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  children: const [
                    SizedBox(
                      height: 13,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.red,
                      size: 25,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Icon(
                      Icons.arrow_circle_down,
                      size: 15,
                    ),
                    Icon(
                      Icons.arrow_circle_down,
                      size: 15,
                    ),
                    Icon(
                      Icons.arrow_circle_down,
                      size: 15,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Icon(
                      Icons.location_on,
                      size: 25,
                      color: Colors.blue,
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const SizedBox(
                      height: 13,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        "${formatDate(widget.dateafter)}, ${DateFormat.jm().format(DateTime.parse(widget.timeafter)) }",
                        style:
                            const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 20,
                      child: Text(
                       widget.startingpoint,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.blue),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    
                    SizedBox(
                       width: 200,
                      height: 20,
                      child: Text(
                        widget.endpoint,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              )),
          Container(
            width: 150,
              alignment: Alignment.topCenter,
              child: Column(
                children:  [
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    widget.cancelby,
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              )),
          // Expanded(
          //     flex: 2,
          //     child: Container(
          //         child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Container(
          //           color: const Color.fromARGB(255, 92, 92, 92),
          //           height: 110,
          //           width: 0.3,
          //         ),
          //         const SizedBox(
          //           width: 10,
          //         ),
          //         Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: const [
          //             Text(
          //               "Travel Time",
          //               style: TextStyle(
          //                   color: Colors.grey,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 12),
          //             ),
          //             SizedBox(
          //               height: 7,
          //             ),
          //             Text(
          //               "45 Min",
          //               style: TextStyle(
          //                   color: Colors.black,
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //             SizedBox(
          //               height: 18,
          //             ),
          //             Text(
          //               "Travel Cost",
          //               style: TextStyle(
          //                   color: Colors.grey,
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //             SizedBox(
          //               height: 7,
          //             ),
          //             Text(
          //               "Rs: 150",
          //               style: TextStyle(
          //                   color: Colors.black,
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ))),
        ],
      ),
    );
  }
}
