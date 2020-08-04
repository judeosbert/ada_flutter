import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper{
  static final SharedPrefHelper _instance = SharedPrefHelper._internal();
  final String closePopupKey = "close-popup";
  SharedPreferences _pref;
  SharedPrefHelper._internal();
  factory SharedPrefHelper() => _instance;

  void closeChangeLogPopup() async {
    _pref = _pref??await SharedPreferences.getInstance();
    await _pref.setBool(closePopupKey, true);
  }

  Future<bool> shouldShowPopup() async {
    _pref = _pref??await SharedPreferences.getInstance();
    return !(_pref.getBool(closePopupKey)??false);
  }


}