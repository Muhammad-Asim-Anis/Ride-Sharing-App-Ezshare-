import 'dart:io';
import 'package:ezshare/Riderscreens/screens/riderdestination.dart';
import 'package:ezshare/aftersplashscreen.dart';
import 'package:ezshare/homedrawer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezshare/Customerscreens/screens/cutomer_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfilePageScreen extends StatefulWidget {
  final String userid;
  final String username;
  const ProfilePageScreen(
      {super.key, required this.userid, required this.username});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  final storage = FirebaseStorage.instance;
  TextEditingController? username;
  TextEditingController? phonenum;
  String phone = "", gender = "";
  DateTime? pickedDate;
  String formattedDate = "";
  List<String> items = ["Male", "Female"];
  File? image;
  final ImagePicker picker = ImagePicker();
  dynamic downloadUrl = "";
  @override
  void initState() {
    super.initState();
    username = TextEditingController(text: widget.username);
    loaddata();
  }

  loaddata() async {
    await users.doc(widget.userid).get().then((value) {
      setState(() {
        phone = value["id"];
        try {
          gender = value["gender"];
        } catch (e) {
          gender = "";
        }
        try {
          formattedDate = value["dateofbirth"];
        } catch (e) {
          formattedDate = "";
        }
        try {
          downloadUrl = value["imageurl"];
        } catch (e) {
          downloadUrl = "";
        }

        phonenum = TextEditingController(text: phone);
      });
    });
  }

  //we can upload image from camera or from gallery based on parameter
  Future<void> getImage(ImageSource media) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: media);

    if (pickedFile != null && downloadUrl != "") {
      setState(() {
        image = File(pickedFile.path);
      });
      await storage.refFromURL(downloadUrl).delete();
      final storageRef =
          storage.ref().child('images/${DateTime.now().toString()}');
      final uploadTask = storageRef.putFile(image!);
      final snapshot = await uploadTask.whenComplete(() {});

      downloadUrl = await storageRef.getDownloadURL();

      AfterSplashScreenLoader.downloadurl = downloadUrl;
      // Save the photo information to Firestore
      await users.doc(widget.userid).update({
        'imageurl': downloadUrl,
        'imagetimestamp': DateTime.now(),
      });
      setState(() {});
    } else if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });

      final storageRef =
          storage.ref().child('images/${DateTime.now().toString()}');
      final uploadTask = storageRef.putFile(image!);
      final snapshot = await uploadTask.whenComplete(() {});

      downloadUrl = await storageRef.getDownloadURL();

      // Save the photo information to Firestore
      await users.doc(widget.userid).update({
        'imageurl': downloadUrl,
        'imagetimestamp': DateTime.now(),
      });
      
    }
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button, user can delete image from gallery
                    onPressed: () async {
                      await storage.refFromURL(downloadUrl).delete();
                      await users.doc(widget.userid).update({
                         'imageurl': "",
                         'imagetimestamp': DateTime.now(),
                      });
                      setState(() {
                        downloadUrl = "";
                        AfterSplashScreenLoader.downloadurl = downloadUrl;
                      });
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.delete),
                        Text('Delete the image'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

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
              onPressed: () {
                if (HomeDrawer.currentroute == "customermainscreen") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => customerhome(
                          userid: widget.userid,
                          username: widget.username,
                        ),
                      ));
                }
                if (HomeDrawer.currentroute == "Ridermainscreen") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RiderDestinationSetScreen(
                          userid: widget.userid,
                          username: widget.username,
                        ),
                      ));
                }
                if (HomeDrawer.currentroute == "") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => customerhome(
                          userid: widget.userid,
                          username: widget.username,
                        ),
                      ));
                }
              },
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  myAlert();
                },
                child: (downloadUrl != "")
                    ? Container(
                        height: 114,
                        width: 139,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("$downloadUrl"),
                        ))
                    : Container(
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          CupertinoIcons.person_circle,
                          color: Colors.blue,
                          size: 200,
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 271,
              height: 53,
              child: TextField(
                enableSuggestions: false,
                controller: username,
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
                keyboardType: TextInputType.none,
                controller: (formattedDate.isNotEmpty)
                    ? TextEditingController(text: formattedDate)
                    : TextEditingController(),
                onTap: () async {
                  pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    setState(() {
                      formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate!);
                    });
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
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
              height: 60,
              child: DropdownButtonFormField(
                value: (gender.isNotEmpty) ? gender : items[0],
                decoration: InputDecoration(
                  hintText: "Gender",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 1)),
                  filled: true,
                  prefixIcon: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 25, top: 10),
                        child: Transform.rotate(
                          angle: 340,
                          child: const Icon(
                            Icons.female,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const Icon(
                          Icons.male,
                          color: Colors.blue,
                          size: 20,
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
                items: items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {
                  gender = value!;
                },
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            SizedBox(
              width: 271,
              height: 53,
              child: TextField(
                enabled: false,
                controller: phonenum,
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
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () async {
                  if (username!.text.isNotEmpty &&
                      gender.isNotEmpty &&
                      formattedDate.isNotEmpty) {
                    await users.doc(widget.userid).update({
                      "username": username!.text.toString(),
                      "dateofbirth": formattedDate.toString(),
                      "gender": gender,
                    });
                    // ignore: use_build_context_synchronously
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => customerhome(
                            userid: widget.userid,
                            username: username!.text.toString(),
                          ),
                        ));
                  }
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
