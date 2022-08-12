


import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClass{

  static SharedPreferenceClass sharedPreferenceClassInstance=SharedPreferenceClass();
  SharedPreferences? sharedPreferences;
  bool canShowOnBoredScreen=false;


 Future<SharedPreferences> get getSharedPreferenceClassInstance async {
            return sharedPreferences??await SharedPreferences.getInstance();
  }

updateBooleans(bool value ){
   canShowOnBoredScreen=value;
}

}