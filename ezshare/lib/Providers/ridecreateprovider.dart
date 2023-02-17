import 'package:flutter/cupertino.dart';

class RideCreateProvider extends ChangeNotifier {
   bool _isClicked1 = false,
      _isClicked2 = false,
      _isClicked3 = false,
      _isSetvehicle = false;
    String _isVehicle = "";
   bool get isClicked1 => _isClicked1; 
   bool get isClicked2 => _isClicked2; 
   bool get isClicked3 => _isClicked3; 
   bool get isSetvehicle => _isSetvehicle; 
   String get isVehicle => _isVehicle;
    void setClick1()
  {
    _isClicked1 = true;
     notifyListeners();
  } 

    void setClick2()
  {
    _isClicked2 = true;
     notifyListeners();
  } 

    void setClick3()
  {
    _isClicked3 = true;
     notifyListeners();
  } 
   
   void setFalseClick1()
  {
    _isClicked1 = false;
     notifyListeners();
  } 

    void setFalseClick2()
  {
    _isClicked2 = false;
     notifyListeners();
  } 

    void setFalseClick3()
  {
    _isClicked3 = false;
     notifyListeners();
  } 
 
    void setVehicle()
  {
    _isSetvehicle = true;
     notifyListeners();
  } 

   void setVehicleFalse()
  {
    _isSetvehicle = false;
     notifyListeners();
  } 

    void setisVehicle(String vehiclename)
  {
    _isVehicle = vehiclename;
     notifyListeners();
  } 
}