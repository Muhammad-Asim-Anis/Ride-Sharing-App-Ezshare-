import 'package:ezshare/otpauthenticate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneAuthenticateScreen extends StatefulWidget {
  const PhoneAuthenticateScreen({super.key});

  @override
  State<PhoneAuthenticateScreen> createState() =>
      _PhoneAuthenticateScreenState();
}

class _PhoneAuthenticateScreenState extends State<PhoneAuthenticateScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController phonenum = TextEditingController();
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              width: 320,
              child: Text(
                "Enter Your",
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2),
              ),
            ),
            Text(
              "Phone Number",
              style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 0, 157, 207),
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: phonenum,
                decoration: InputDecoration(
                    hintText: "Phone Number",
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: Colors.blue,
                    ),
                    fillColor: Colors.yellow,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 218, 216, 216)))),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            InkWell(
              onTap: () {},
              hoverColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Privacy Policy",
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                ),
              ),
            ),
            InkWell(
                onTap: () async {
                  String formatedphonenumber =
                      "+92${phonenum.text.toString().substring(1)}"; 
                  if (phonenum.text.isNotEmpty) {
                    await auth.verifyPhoneNumber(
                      phoneNumber: formatedphonenumber,
                      verificationCompleted: (_) {},
                      verificationFailed: (error) {},
                      codeSent: (verificationId, forceResendingToken) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpauthenticatePage(
                                phonenum: formatedphonenumber,
                                otpcode: forceResendingToken.toString(),
                                verificationId: verificationId,
                              ),
                            ));
                      },
                      codeAutoRetrievalTimeout: (verificationId) {},
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter number "),
                    ));
                  }
                },
                hoverColor: Colors.white,
                child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue, width: 1)),
                      width: 300,
                      child: Text(
                        "Send OTP",
                        style: GoogleFonts.poppins(
                            fontSize: 20, color: Colors.blue),
                        textAlign: TextAlign.center,
                      )),
                ))
          ],
        ),
      ),
    ));
  }
}
