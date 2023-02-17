import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RiderFeedbackCard extends StatefulWidget {
  const RiderFeedbackCard({super.key});

  @override
  State<RiderFeedbackCard> createState() => _RiderFeedbackCardState();
}

class _RiderFeedbackCardState extends State<RiderFeedbackCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
                height: 438,
                width: 275,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                          height: 122,
                          width: 149,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc=",
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rider Name",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Rs: 90",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Rate Your Trip",
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.grey),
                      ),
                      RatingBar.builder(
                        initialRating: 4,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star_rate_rounded,
                          color: Colors.blueAccent,
                        ),
                        onRatingUpdate: (rating) {
                          
                        },
                      ),
                      Container(
                        height: 80,
                        width: 187,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: TextField(
                          controller: TextEditingController(),
                          decoration: InputDecoration(
                            hintText: "Write a Comments",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 33,
                        width: 187,
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
                                  "Submit",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ),
                      ),
                    ]),
              );
  }
}