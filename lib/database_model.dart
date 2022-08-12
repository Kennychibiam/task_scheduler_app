import "dart:convert" as toJSONconverter;

import 'package:flutter/material.dart';

class DatabaseModel {
  String? title;
  String? body;
  String? dateCreated;
  int? isCompleted;

  DatabaseModel(
      {required this.title,
      required this.body,
      required this.dateCreated,
      required this.isCompleted});

  DatabaseModel.toMap();

  Map<String, Object?> convertDataToMap() {
    return {"TITLE": title, "BODY": body, "DATE_CREATED": dateCreated,"IS_COMPLETED":isCompleted};
  }

  List<DatabaseModel> convertToModelClass(
      List<Map<String, dynamic>>? queryResult) {
    //it can also be a type Object?
    return queryResult
            ?.map((e) => DatabaseModel(
                body: e["BODY"],
                title: e["TITLE"],
                dateCreated: e["DATE_CREATED"],
                isCompleted: e["IS_COMPLETED"]))
            .toList() ??
        [];
  }
}
