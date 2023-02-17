import 'package:ezshare/Customerscreens/screens/cutomer_home.dart';
import 'package:ezshare/Riderscreens/screens/riderdestination.dart';
import 'package:ezshare/Riderscreens/screens/riderridedetails.dart';
import 'package:ezshare/phoneauthenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeDrawer extends StatefulWidget {
  final String userid;
  final String username; 
  const HomeDrawer({super.key, required this.username, required this.userid});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
 
  @override
  initState()
  {
   super.initState();
   
  }
  @override
  void dispose() {
    
    super.dispose();
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
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 0.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 270,
            child: Container(
                margin: const EdgeInsets.only(bottom: 10, top: 30),
                padding: EdgeInsets.zero,
                child: Container(
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(
                              CupertinoIcons.person_circle,
                              color: Colors.blue,
                              size: 200,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.zero,
                              margin:
                                  const EdgeInsets.only(left: 180, top: 140),
                              child: const Icon(Icons.mode_edit,
                                  size: 20,
                                  color: Colors.blue,
                                  textDirection: TextDirection.ltr),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.username,
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                )),
          ),
         
          Container(
            margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
            child:  ListTile(
              onTap: () {
                
              },
                leading: const Icon(
                  CupertinoIcons.home,
                  color: Colors.blue,
                ),
                 trailing:  const Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                title: const Text(
                  "Home",
                  style: TextStyle(color: Colors.black),
                )),
          ),
          Container(
             margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
            child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  RiderDestinationSetScreen(userid: widget.userid,username: widget.username),
                      ));
                },
                leading: const Icon(
                  Icons.history,
                  color: Color.fromARGB(225, 0, 157, 207),
                ),
                 trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                title: const Text(
                  "History",
                  style: TextStyle(color: Colors.black),
                )),
          ),
          Container( margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
            child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  customerhome(userid: widget.userid,username: widget.username),
                      ));
                },
                leading: Image.asset("assets/images/mode.png",width: 20,height: 20,),
                 trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                title: const Text(
                  "Customer Mode",
                  style: TextStyle(color: Colors.black),
                )),
          ),
          Container(
             margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
            child: ListTile(
                onTap: () {
                  // Navigator.pushNamed(context, '/Products');
                },
                leading: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Color.fromARGB(225, 0, 157, 207),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                title: const Text(
                  "Wallet",
                  style: TextStyle(color: Colors.black),
                )),
          ),
          Container(
             margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
            child: ListTile(
                onTap: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  RiderRideBookingDeatilsScreen(userid: widget.userid,username: widget.username),
                      ));
                },
                leading: const Icon(
                  CupertinoIcons.phone,
                  color: Color.fromARGB(225, 0, 157, 207),
                ),
                 trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                title: const Text(
                  "Ride Request",
                  style: TextStyle(color: Colors.black),
                )),
          ),
          Container(
             margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
            child: ListTile(
                onTap: () {
                  // Navigator.pushNamed(context, '/Register');
                },
                leading: const Icon(
                  CupertinoIcons.phone,
                  color: Color.fromARGB(225, 0, 157, 207),
                ),
                 trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                title: const Text(
                  "Contact Us",
                  style: TextStyle(color: Colors.black),
                )),
          ),
         InkWell(
            onTap: () async{
             await FirebaseAuth.instance.signOut();
             setState(() {
                firebaseauthcheck();
             });
            },
            child: Container(
              margin: const EdgeInsets.only(top: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 6),
                      child: const Icon(CupertinoIcons.person_circle,
                          color: Color.fromARGB(225, 0, 157, 207))),
                  const Text("Log out", style: TextStyle(color: Colors.blue))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
