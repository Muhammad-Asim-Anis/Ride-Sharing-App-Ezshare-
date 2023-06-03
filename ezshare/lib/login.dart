import 'package:ezshare/successlogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  final String usernumber;
  static AuthCredential? credential;
  const LoginPage({super.key, required this.usernumber});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  int usercount = 0;
  String userid = "";

  // Future<int> getUserAuthenticate(String number, String username) async {
  //   AggregateQuery count = users
  //       .where("id", isEqualTo: number)
  //       .where("username", isEqualTo: username)
  //       .count();
  //   AggregateQuerySnapshot snap = await count.get();

  //   return snap.count;
  // }

  getUserAuthenticatedetails(String number) async {
    QuerySnapshot detail = await users.where("id", isEqualTo: number).get();
    for (var element in detail.docs) {
      userid = element.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              SizedBox( width: 320,
              child: Text(
                "Enter Your",textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                    color:  Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2),
              ),
            ),
            Text(
              "Name",
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
                  controller: username,
                  decoration: InputDecoration(
                      hintText: "Name",
                      prefixIcon: const Icon(
                        Icons.person,
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
                  onTap: () async {
                    if (username.text != "") {
                      await FirebaseAuth.instance
                          .signInWithCredential(LoginPage.credential!);
                      await users.add({
                        'id': widget.usernumber.toString(),
                        'username': username.text.toString()
                      });
                      await getUserAuthenticatedetails(widget.usernumber);

                      // ignore: use_build_context_synchronously
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuccessPage(
                              userid: userid,
                              username: username.text,
                            ),
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
                          "Login",
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
