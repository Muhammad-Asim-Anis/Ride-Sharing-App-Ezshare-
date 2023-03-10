import 'package:flutter/cupertino.dart';

class AuthenticationProvider extends ChangeNotifier
{
   String _userid = "", _username = "";
  
 
  String get userid => _userid;
   String get username => _username;
   
  
   void setuserID(String userid)
  {
     _userid = userid;
     notifyListeners();
  }

  void setuserName(String username)
  {
     _username = username;
     notifyListeners();
  }
 

  
}