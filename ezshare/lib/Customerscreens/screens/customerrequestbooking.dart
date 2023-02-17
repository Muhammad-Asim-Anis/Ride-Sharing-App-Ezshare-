import 'package:ezshare/Customerscreens/widgets/messagecard.dart';
import 'package:ezshare/Customerscreens/widgets/requestbooking_card.dart';
import 'package:ezshare/Providers/messageprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CustomerRequestBookingScreen extends StatefulWidget {
  
  const CustomerRequestBookingScreen({super.key});

  @override
  State<CustomerRequestBookingScreen> createState() =>
      _CustomerRequestBookingScreenState();
}

class _CustomerRequestBookingScreenState
    extends State<CustomerRequestBookingScreen> {
     
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
   
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
                onPressed: () {
                  // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child:
                  // RiderDestinationSerachScreen(
                  //   userid: widget.userid, username: widget.username,)  ));
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ))),
        actions: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                width: 100,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.my_location_outlined,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Location",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                )),
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
            target: LatLng(24.91638690588, 67.05699002225725), zoom: 14.4746),
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        markers: <Marker>{
          const Marker(
              markerId: MarkerId("1"),
              position: LatLng(24.91638690588, 67.05699002225725),
              infoWindow: InfoWindow(title: "Source Location")),
          const Marker(
            markerId: MarkerId("2"),
            position: LatLng(24.902397373647943, 67.07289494395282),
            infoWindow: InfoWindow(title: "destination Location"),
          )
        },
      ),
      bottomNavigationBar: DraggableScrollableSheet(
        initialChildSize: .6,
        minChildSize: .1,
        maxChildSize: .7,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
              child: Consumer<MessageCardProvider>(builder: (BuildContext context, value, Widget? child) { 
                return (value.isClick)? const CustomerMessageCard()  : const CustomerRequestBookingCard();
               },
             ));
        },
      ),
    );
  }
}
