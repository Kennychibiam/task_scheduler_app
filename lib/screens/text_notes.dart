import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_app/models/database.dart';
import 'package:to_do_list_app/database_model.dart';
import 'package:to_do_list_app/widgets/show_dialog_date_time_widget.dart';

class TextNotesScreen extends StatefulWidget {
  String? title;
  String? body;
  String? dateCreated;
  int? isCompleted;
  String? currentNotificationDate;
  String? currentNotificationTime;

  TextNotesScreen(
      {Key? key, this.title, this.body, this.dateCreated, this.isCompleted})
      : super(key: key);

  @override
  State<TextNotesScreen> createState() => _TextNotesScreenState();
}

class _TextNotesScreenState extends State<TextNotesScreen> {
  String? originalTitle;
  late TextEditingController titleTextEditingController =
      TextEditingController();
  late TextEditingController bodyTextEditingController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.title != null) {
        originalTitle = widget.title!;
        titleTextEditingController.text = widget.title!.split("///")[0];
      }
      if (widget.body != null) {
        bodyTextEditingController.text = widget.body!;
      }
      if (widget.dateCreated == null) {
        setState(() {
          widget.dateCreated = modifiedDate(getCurrentDate());
        });
      }

      widget.isCompleted ??= 0;
    });
  }

  @override
  void dispose() {
    super.dispose();
    bodyTextEditingController.dispose();
    titleTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        if (titleTextEditingController.text.isNotEmpty) {
          if (originalTitle != null) {
            DatabaseModel databaseModel = DatabaseModel(
                dateCreated: widget.dateCreated,
                isCompleted: widget.isCompleted ?? 0,
                title: originalTitle,
                body: bodyTextEditingController.text);
            await DatabaseClass.instance.insertIntoTable(
                tableName: DatabaseClass.TO_DO_LIST_TABLE,
                modelDatabase: databaseModel);
          } else {
            DatabaseModel databaseModel = DatabaseModel(
                dateCreated: widget.dateCreated,
                isCompleted: widget.isCompleted ?? 0,
                title:
                    "${titleTextEditingController.text}///${widget.dateCreated}",
                body: bodyTextEditingController.text);
            await DatabaseClass.instance.insertIntoTable(
                tableName: DatabaseClass.TO_DO_LIST_TABLE,
                modelDatabase: databaseModel);
          }
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("TODO"),
          actions: [
            IconButton(
                onPressed: () async {
                  dynamic selectedDateTime = await showDialogWidget(
                      context,
                      "Set Notifications",
                      updateSelectedDate,
                      updateSelectedTime,
                      currentNotificationDate: widget.currentNotificationDate,
                      currentNotificationTime: widget.currentNotificationTime);
                  if (selectedDateTime != null &&
                      widget.currentNotificationDate != null &&
                      widget.currentNotificationTime != null) {


                  }
                },
                icon: Icon(Icons.alarm_on_rounded)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text("created: ${widget.dateCreated?.replaceAll("-", "/")}"),
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: TextField(
                  maxLines: 1,
                  controller: titleTextEditingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: bodyTextEditingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Textnotes",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getCurrentDate() {
    String date = DateTime.now().toString();
    List<String> dateList = date.split(" ");
    List<String> dateList2 = dateList.first.split("-");
    String dateTime = dateList2[1] +
        "-" +
        dateList2.last +
        "-" +
        dateList2.first +
        " " +
        dateList.last.split(".")[0];
    return dateTime;
    //07-30-2022 18:43:17.849331 ----result
  }

  String modifiedDate(String date) {
    List<String> colonSplit = date.split(":");
    String finalDate = "";
    for (int i = 0; i < colonSplit.length - 1; ++i) {
      if (i == colonSplit.length - 2)
        finalDate += ":" + colonSplit[i];
      else
        finalDate += colonSplit[i];
    }
    return finalDate;
  }

  Future<dynamic> showDatePickerWidget(BuildContext context) async {
    DateTime dateTime = DateTime.now();
    dynamic selectedDate = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(dateTime.year),
        lastDate: DateTime(dateTime.year + 4));

    return selectedDate;
  }

  String modifySelectedDatePicker(String date) {
    //to modify the dat that user selects for notification

    List<String> dateList = date.split(" ");
    List<String> dateList2 = dateList.first.split("-");
    String dateTime =
        dateList2[1] + "-" + dateList2.last + "-" + dateList2.first;
    return dateTime.replaceAll("-", "/");
    //07-30-2022 18:43:17.849331 ----result
  }

  String modifySelectedTimePicker(String time) {
    return time
        .replaceAll("TimeofDay", "")
        .replaceAll("(", "")
        .replaceAll(")", "");
  }

  updateSelectedDate(String date) {
    widget.currentNotificationDate = date;

    showDialogWidget(
        context, "Set Notifications", updateSelectedDate, updateSelectedTime,
        currentNotificationDate: widget.currentNotificationDate,
        currentNotificationTime: widget.currentNotificationTime);
  }

  updateSelectedTime(String time) {
    widget.currentNotificationTime = time;
    showDialogWidget(
        context, "Set Notifications", updateSelectedDate, updateSelectedTime,
        currentNotificationDate: widget.currentNotificationDate,
        currentNotificationTime: widget.currentNotificationTime);
  }
}
