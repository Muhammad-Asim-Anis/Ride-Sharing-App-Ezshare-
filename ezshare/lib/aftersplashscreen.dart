import 'package:ezshare/Customerscreens/screens/cutomer_home.dart';
import 'package:ezshare/phoneauthenticate.dart';
import 'package:ezshare/successlogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AfterSplashScreenLoader extends StatefulWidget {
 static String downloadurl = "";
  const AfterSplashScreenLoader({super.key});

  @override
  State<AfterSplashScreenLoader> createState() =>
      _AfterSplashScreenLoaderState();
}

class _AfterSplashScreenLoaderState extends State<AfterSplashScreenLoader> {
  String userid = "", username = "", usernumber = "";
  bool userstatus = false;
  User? userdata;
  CollectionReference users = FirebaseFirestore.instance.collection("Users");

  @override
  void initState() {
    super.initState();
    firebaseauthcheck();
  }
  
  firebaseauthcheck() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          userstatus = true;
          userdata = user;
          usernumber = userdata!.phoneNumber!;
          SuccessPage.user = user;
        });
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: users.where("id", isEqualTo: usernumber).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
         
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            ));
          } else if (userstatus) {
            QuerySnapshot detail = snapshot.data;
            for (var element in detail.docs) {
              userid = element.id;
              username = element["username"];
             
              try {
                AfterSplashScreenLoader.downloadurl = element["imageurl"];
              } catch (e) {
                AfterSplashScreenLoader.downloadurl = "";
              }
              
            }
          }
          
          return (userstatus && username != "" && userid != "")
              ? customerhome(
                  username: username,
                  userid: userid,
                )
              : const PhoneAuthenticateScreen();
        },
      ),
    );
  }
}
