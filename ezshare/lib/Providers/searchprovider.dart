import 'package:flutter/cupertino.dart';

class SearchProvider extends ChangeNotifier{
   String _search  = "";
   String get searchval => _search;


   void setSearchvalue(String search){
     _search = search;
     notifyListeners();
  }
}