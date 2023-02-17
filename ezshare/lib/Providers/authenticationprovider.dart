import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationProvider extends ChangeNotifier
{
   String _userid = "", _username = "", _usernumber = "";
  bool _userstatus = false;
  User? _user;
   User? get user => _user;
  String get userid => _userid;
   String get username => _username;
    String get usernumber => _usernumber;
     bool get userstatus => _userstatus;
  void setuserData(User user)
  {
     _user =user;
     notifyListeners();
  }
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
  void setuserNumber(String usernumber)
  {
     _usernumber = usernumber;
     notifyListeners();
  }

  void setUserStatus()
  {
     _userstatus = true;
     notifyListeners();
  }

   void unsetUserStatus()
  {
     _userstatus = false;
     notifyListeners();
  }
}