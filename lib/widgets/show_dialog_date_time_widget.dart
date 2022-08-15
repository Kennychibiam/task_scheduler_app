import 'package:flutter/material.dart';


dynamic date;
dynamic time;

Future<dynamic> showDialogWidget(
        BuildContext context, String title, Function updateSelectedDate,Function updateSelectedTime,Function setNotification ,{String ?currentNotificationDate, String ?currentNotificationTime}) {



  return showDialog(
      context: context,
      builder: (builder) =>
          AlertDialog(
            title: Text(title),
            content: Container(
              height: 130.0,
              child: Column(
                children: [
                  ListTile(
                    title: Column(
                      children: [
                        Text(currentNotificationDate ?? "Choose Date here",),

                        Divider(color: Colors.black,),
                      ],
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.date_range, color: Colors.blue,),
                        onPressed: () async {
                          date = await showDatePickerWidget(context);
                          if(date!=null){
                          currentNotificationDate=modifySelectedDatePicker(date.toString());
                          Navigator.pop(context);
                          updateSelectedDate(currentNotificationDate);
                          }

                        }),),
                  ListTile(
                    title: Column(
                      children: [
                        Text(currentNotificationTime ?? "Choose Time here",),
                        Divider(color: Colors.black,),
                      ],
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.alarm_on_rounded, color: Colors.blue),
                        onPressed: () async {
                          time = await showTimePickerWidget(context);
                          if(time!=null){
                            currentNotificationTime=modifySelectedTimePicker(time.toString());
                            Navigator.pop(context);
                            updateSelectedTime(currentNotificationTime);

                          }
                        }),)
                ],
              ),
            ),
            actions: [
              TextButton(child: Text("Cancel"), onPressed: () {
                Navigator.pop(context);
              }),
              TextButton(child: Text("OK"), onPressed: () {
                setNotification();

                Navigator.pop(context, [date.toString(), time.toString()]);
              },),
            ],
          ));
}

String modifySelectedDatePicker(String date) {//to modify the dat that user selects for notification

  List<String> dateList = date.split(" ");
  List<String> dateList2 = dateList.first.split("-");
  String dateTime = dateList2[1] +
      "-" +
      dateList2.last +
      "-" +
      dateList2.first;
  return dateTime.replaceAll("-", "/");
  //07-30-2022 18:43:17.849331 ----result
}

String modifySelectedTimePicker(String time){
  return time.replaceAll("TimeOfDay", "").replaceAll("(", "").replaceAll(")", "");
}

Future<dynamic> showDatePickerWidget( BuildContext context)async{
  DateTime dateTime=DateTime.now();
  dynamic selectedDate= await showDatePicker(
      context:context,
      initialDate: dateTime,
      firstDate: DateTime(dateTime.year),
      lastDate: DateTime(dateTime.year+4));

  return selectedDate;
}

Future<dynamic> showTimePickerWidget( BuildContext context)async{

  dynamic selectedTime= await showTimePicker(
      context:context,
      initialTime: TimeOfDay.now(),
  );

  return selectedTime;
}
