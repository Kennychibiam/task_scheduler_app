import 'package:flutter/material.dart';
import 'package:to_do_list_app/ajebutter.dart';
import 'package:to_do_list_app/models/database.dart';
import 'package:to_do_list_app/database_model.dart';
import 'package:to_do_list_app/Screens/to_do_screen.dart';
import 'package:to_do_list_app/models/shared_preferences.dart';
import 'package:to_do_list_app/route_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/onboarding_screen.dart';
import 'package:to_do_list_app/theme/layout_theme.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var sharedPreferenceInstance = await SharedPreferenceClass
      .sharedPreferenceClassInstance.getSharedPreferenceClassInstance;
  SharedPreferenceClass.sharedPreferenceClassInstance.canShowOnBoredScreen =
      sharedPreferenceInstance.getBool("ShowOnBoardingScreen") ?? true;

  runApp(MaterialApp(
    theme: LayOutTheme.layoutTheme,
    // theme: ThemeData.light().copyWith(
    //   unselectedWidgetColor: Colors.white,
    //),
    debugShowCheckedModeBanner: false,
    onGenerateRoute: RouteGenerator.routeController,
    initialRoute: RouteGenerator.HOME_SCREEN,
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showOnboardingScreen = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showOnboardingScreen = SharedPreferenceClass
        .sharedPreferenceClassInstance.canShowOnBoredScreen;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SharedPreferenceClass
            .sharedPreferenceClassInstance.canShowOnBoredScreen
        ? OnBoardingScreen()
        : ToDoScreen();
  }
}
