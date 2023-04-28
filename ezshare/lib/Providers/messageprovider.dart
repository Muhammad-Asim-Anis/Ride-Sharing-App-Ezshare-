import 'package:flutter/cupertino.dart';

class MessageCardProvider extends ChangeNotifier {
   String _roomid = "";
   bool _isClick = false; 
   int _itemcount = 0;
   int get itemcount => _itemcount;
   bool get isClick => _isClick;
   String get roomid => _roomid;
  void setClick()
  {
    _isClick = true;
     notifyListeners();
  }
   void setItemCount(int itemcount)
  {
    _itemcount = itemcount;
     notifyListeners();
  }
   void setClickFalse()
  {
    _isClick = false;
     notifyListeners();
  }

    void setRoomId(String roomid)
  {

    _roomid = roomid;
     notifyListeners();
  }

   void deleteRoomId()
  {

    _roomid = "";
     notifyListeners();
  }
}