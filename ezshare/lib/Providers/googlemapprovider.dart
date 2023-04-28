import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapProvider extends ChangeNotifier {
  List<Marker> _markers = [];
  LatLng _position = const LatLng(0, 0);
  bool _pickup = false, _dropoff = false; 
  double _latitude = 0.0;
  double _longitude = 0.0;
  LatLng get position => _position;
   bool get pickup => _pickup; 
    bool get dropoff => _dropoff; 
    List<Marker> get markers => _markers;
    double get latitude => _latitude;
     double get longitude => _longitude;
   void setpickup() {
    _pickup = true ;
    notifyListeners();
  }

   void setdropoff() {
    _dropoff = true;
    notifyListeners();
  }

  void unsetpickup() {
    _pickup = false ;
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

  void updatelatitude(double latitude)
  {
    _latitude = latitude;
    notifyListeners();
  }
   void updatelongitude(double lonitude)
  {
    _longitude = lonitude;
    notifyListeners();
  }
  void updatePosition(LatLng newPosition) {
    _position = newPosition;
    notifyListeners();
  }
}