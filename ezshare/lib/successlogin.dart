import 'package:ezshare/Customerscreens/screens/cutomer_home.dart';
import 'package:ezshare/phoneauthenticate.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessPage extends StatefulWidget {
  final String userid;
  final String username;
  static User? user;
  const SuccessPage({super.key, required this.userid, required this.username});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
 @override 
 initState()
 {
   super.initState();
   firebaseauthcheck();
 }
 
 firebaseauthcheck()
{
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          
        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const  PhoneAuthenticateScreen(),
                        ));
        });
      } 
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 70,
              margin: const EdgeInsets.symmetric(vertical: 0),
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blue,
              ),
              child: const Center(
                child: Icon(
                  CupertinoIcons.checkmark_alt,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Text(
              "You are Successfully login",
              style: GoogleFonts.poppins(fontSize: 29, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 150,
            ),
            InkWell(
                onTap: () async {
                  //  await auth.signInWithCredential(LoginPage.credential!);

                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => customerhome(
                          userid: widget.userid,
                          username: widget.username,
                        ),
                      ));
                },
                hoverColor: Colors.white,
                child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue, width: 1)),
                      width: 300,
                      child: Text(
                        "Confirm",
                        style: GoogleFonts.poppins(
                            fontSize: 20, color: Colors.blue),
                        textAlign: TextAlign.center,
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
