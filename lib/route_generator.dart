import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:to_do_list_app/main.dart';
import 'package:to_do_list_app/test.dart';

import 'Screens/text_notes_screen.dart';

class RouteGenerator {
  static const String HOME_SCREEN = "MyApp";
  static const String TEXT_NOTES_SCREEN = "ToDoScreen";

  static Route<dynamic> routeController(RouteSettings settings) {
    switch (settings.name) {
      case HOME_SCREEN:
        return MaterialPageRoute(builder: (context) => MyApp());
      case TEXT_NOTES_SCREEN:
        dynamic argument = settings.arguments as Map;

        return MaterialPageRoute(
            builder: (context) => TextNotesScreen(
                  body: argument["Body"],
                  title: argument["Title"],
                  dateCreated:argument["Date"] ,
                  isCompleted: argument["IsCompleted"],
                ));

      default:
        return MaterialPageRoute(builder: (context) => MyApp());
    }
  }


}
