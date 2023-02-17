import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Customerscreens/screens/cutomer_home.dart';
import 'package:ezshare/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class OtpauthenticatePage extends StatefulWidget {
  final String phonenum;
  final String otpcode;
  final String verificationId;
  const OtpauthenticatePage(
      {super.key,
      required this.phonenum,
      required this.otpcode,
      required this.verificationId});

  @override
  State<OtpauthenticatePage> createState() => _OtpauthenticatePagewidget();
}

class _OtpauthenticatePagewidget extends State<OtpauthenticatePage> {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  FirebaseAuth auth = FirebaseAuth.instance;
  static const maxseconds = 60;
  int timer = maxseconds;
  Timer? time;
  TextEditingController codenum = TextEditingController();
  int count = 0;
  String userid = "",username = "";
  @override
  void initState() {
    super.initState();

    SmsVerification.startListeningSms().then((value) => codenum.text = value!);
    // codenum.text = widget.otpcode;
    timerrun();
  }

  void timerrun() {
    time = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (timer != 0) {
          timer--;
        }
      });
    });
  }

  Future<int> getUserAuthenticate(String number) async {
    AggregateQuery count = users
        .where("id", isEqualTo: number)
        .count();
    AggregateQuerySnapshot snap = await count.get();

    return snap.count;
  }

   getUserAuthenticatedetails(String number) async {
    QuerySnapshot detail = await users
        .where("id", isEqualTo: number)
        .get();
    for (var element in detail.docs) {
      userid = element.id;
      username = element["username"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                "Please Enter the Otp code send on your number",
                textAlign: TextAlign.center,
                style: GoogleFonts.khula(
                  fontSize: 15,
                ),
              ),
              Text(widget.phonenum,
                  style: GoogleFonts.khula(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 0, 157, 207),
                  )),
              SizedBox(
                height: 50,
                width: 50,
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation(Colors.grey),
                      strokeWidth: 5,
                      backgroundColor: Colors.blue,
                      value: timer / maxseconds,
                    ),
                    Center(
                      child: Text(
                        "$timer",
                        style: const TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              TextFieldPin(
                textController: codenum,
                autoFocus: true,
                codeLength: 6,
                alignment: MainAxisAlignment.center,
                defaultBoxSize: 45.0,
                margin: 5.0,
                selectedBoxSize: 45.0,
                selectedDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 194, 191, 191)),
                textStyle: GoogleFonts.khula(fontSize: 20, color: Colors.white),
                defaultDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 194, 191, 191)),
                onChange: (otpcodeverify) {},
              ),
              const SizedBox(
                height: 70,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      timer = maxseconds;
                    });
                    auth.verifyPhoneNumber(
                      forceResendingToken: int.parse(widget.otpcode),
                      phoneNumber: widget.phonenum.toString(),
                      verificationCompleted: (_) {},
                      verificationFailed: (error) {},
                      codeSent: (verificationId, forceResendingToken) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpauthenticatePage(
                                phonenum: widget.phonenum.toString(),
                                otpcode: forceResendingToken.toString(),
                                verificationId: verificationId,
                              ),
                            ));
                      },
                      codeAutoRetrievalTimeout: (verificationId) {},
                    );
                  },
                  hoverColor: Colors.white,
                  child: (timer == 0)
                      ? Center(
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.blue, width: 1)),
                              width: 300,
                              child: Text(
                                "Send OTP Again",
                                style: GoogleFonts.poppins(
                                    fontSize: 20, color: Colors.blue),
                                textAlign: TextAlign.center,
                              )),
                        )
                      : const Center()),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () async {
                    if (codenum.text != "") {
                      await getUserAuthenticate(widget.phonenum).then((value) => count = value);
                                 
                      final credential = PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: codenum.text);
                      LoginPage.credential = credential;
                      // await auth.signInWithCredential(credential);
                      if(count == 1)
                      {
                        await getUserAuthenticatedetails(widget.phonenum);

                        await FirebaseAuth.instance
                          .signInWithCredential(credential);

                         // ignore: use_build_context_synchronously
                         await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => customerhome(
                              userid: userid,
                              username: username,
                            ),
                          ));
                      }
                      else if(count == 0)
                      {

                      // ignore: use_build_context_synchronously
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(
                              usernumber: widget.phonenum,
                            ),
                          ));
                      } 
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
                          "Confirm",
                          style: GoogleFonts.poppins(
                              fontSize: 20, color: Colors.blue),
                          textAlign: TextAlign.center,
                        )),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
