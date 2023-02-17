import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(left: 4, right: 5),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                color: Colors.blue,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  )
                ]),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
              onPressed: () {},
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                          height: 114,
                          width: 139,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc=",
                            ),
                          )),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 271,
              height: 53,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 1)),
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.person_outline_outlined,
                    color: Colors.blue,
                  ),
                  hoverColor: Colors.white,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 1)),
                ),
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            SizedBox(
              width: 271,
              height: 53,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Date of Birth",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 1)),
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.blue,
                  ),
                  hoverColor: Colors.white,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 1)),
                ),
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            SizedBox(
              width: 271,
              height: 53,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Gender",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 1)),
                  filled: true,
                  prefixIcon: Stack( alignment: Alignment.center,
                    children:  [
                       Container(
                        margin: const EdgeInsets.only(bottom: 25,top: 10),
                         child: Transform.rotate(
                           angle: 340,
                           child: const Icon(
                            Icons.female,
                            color: Colors.red,size: 20,
                                             ),
                         ),
                       ),
                       Container(
                        margin: const EdgeInsets.only(top: 10),
                         child: const Icon(
                          Icons.male,
                          color: Colors.blue,size: 20,
                      ),
                       ),
                    ],
                  ),
                  hoverColor: Colors.white,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 1)),
                ),
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            SizedBox(
              width: 271,
              height: 53,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Phone no",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 1)),
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Colors.blue,
                  ),
                  hoverColor: Colors.white,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 1)),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
                  onTap: () {
                   
                  },
                  hoverColor: Colors.white,
                  child: Center(
                    child: Container(
                      height: 45,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blue, width: 1)),
                        width: 280,
                        child: Center(
                          child: Text(
                            "Confirm",
                            style: GoogleFonts.poppins(
                                fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ))
          ],
        ),
      ),
    );
  }
}
