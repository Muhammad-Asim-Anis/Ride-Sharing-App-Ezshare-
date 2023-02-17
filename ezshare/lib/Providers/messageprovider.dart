import 'package:flutter/cupertino.dart';

class MessageCardProvider extends ChangeNotifier {
   bool _isClick = false;
   bool get isClick => _isClick;
  void setClick()
  {
    _isClick = true;
     notifyListeners();
  }
}