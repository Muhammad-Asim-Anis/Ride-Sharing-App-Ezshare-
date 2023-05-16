import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideStartProvider extends ChangeNotifier {
  List<Marker> _markers = []; Map<String,dynamic> _userdata = {};
  String _startingaddress = "your pickup location here", _endaddress = "your dropoff locatiom here";
  LatLng _position = const LatLng(0, 0);
  bool _pickup = false, _dropoff = false;
  double _distance = 0.0;
  int _time = 0;
  double _latitude = 0.0;
  double _longitude = 0.0;
   double get distance => _distance;
  int get time => _time;
  LatLng get position => _position;
  bool get pickup => _pickup;
  bool get dropoff => _dropoff;
  List<Marker> get markers => _markers;
  Map<String,dynamic> get userdata => _userdata;
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get startingaddress => _startingaddress;
  String get endaddress => _endaddress;
  void setmapuserdata(Map<String,dynamic> data){
     _userdata = data;
     notifyListeners();
  }
  void unsetmapuserdata()
  {
     _userdata = {};
     notifyListeners();
  }
   void setDistance(double distance)
  {
    _distance = distance;
    notifyListeners();
  }

  void setTime(int time)
  {
    _time = time;
    notifyListeners();
  } 

   void unsetDistance( )
  {
    _distance = 0.0;
    notifyListeners();
  }

  void unsetTime()
  {
    _time = 0;
    notifyListeners();
  }
  
  void setStartingaddress(String startaddress)
  {
    _startingaddress = startaddress;
    notifyListeners();
  }

  void setEndaddress(String endingaddress)
  {
    _endaddress = endingaddress;
    notifyListeners();
  }

  void unsetStartingaddress()
  {
    _startingaddress = "";
    notifyListeners();
  }

  void unsetEndaddress()
  {
    _endaddress = "";
    notifyListeners();
  }



  void setpickup() {
    _pickup = true;
    notifyListeners();
  }

  void setdropoff() {
    _dropoff = true;
    notifyListeners();
  }

  void unsetpickup() {
    _pickup = false;
    notifyListeners();
  }

  void unsetdropoff() {
    _dropoff = false;
    notifyListeners();
  }

  void setMarker(Marker marker) {
    _markers.add(marker);
    notifyListeners();
  }

  void updatelatitude(double latitude) {
    _latitude = latitude;
    notifyListeners();
  }

  void updatelongitude(double lonitude) {
    _longitude = lonitude;
    notifyListeners();
  }

  void updatePosition(LatLng newPosition) {
    _position = newPosition;
    notifyListeners();
  }
}
