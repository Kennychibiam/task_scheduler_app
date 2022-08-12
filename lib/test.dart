void main(){

List<dynamic>mutilist=[1,"2","3","hello",25.4];

print(mutilist[4].runtimeType);
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
