import 'package:flutter/material.dart';

Future<dynamic> showDialogWidget(
        BuildContext context, String title, String message) =>
    showDialog(
        context: context,
        builder: (builder) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                    TextButton(child: Text("No"),onPressed: (){Navigator.pop(context,[false]);}),
                    TextButton(child: Text("Yes"), onPressed: (){Navigator.pop(context,[true]);},),
              ],
            ));
