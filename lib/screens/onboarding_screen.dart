import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_list_app/models/shared_preferences.dart';
import 'package:to_do_list_app/route_generator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLastPage=false;
  late PageController pageController = PageController();
  List<String> onboardScreenList = [
    "TO DO LIST APP",
    "PLAN YOUR DAY BY WRITING NOTES",
    "CREATE NOTIFICATIONS AND SCHEDULES"
  ];

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: PageView(
          onPageChanged: (pageIndex){
            if(pageIndex==2){
              setState(() {
                isLastPage=true;
              });
            }
            else{
              setState(() {
                isLastPage=false;
              });
            }
          },
          controller: pageController,
          scrollDirection: Axis.horizontal,
          children: [
            onBoardPages(0),
            onBoardPages(1),
            onBoardPages(2),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 80.0,
        //padding: const EdgeInsets.only(bottom: 80.0),
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            !isLastPage?TextButton(
              onPressed: () {
                pageController.jumpToPage(2);
              },
              child: const Text(
                "SKIP",
                style: TextStyle(color: Colors.white),
              ),
            ):SizedBox(width: 70.0,),
            Center(
              child: SmoothPageIndicator(
                  effect: WormEffect(
                    spacing: 16,
                    dotColor: Colors.black45,
                    activeDotColor: Colors.white,
                  ),
                  onDotClicked: (pageIndex) => pageController.animateToPage(
                      pageIndex,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn),
                  count: 3,
                  controller: pageController),
            ),
            isLastPage?TextButton(onPressed: (){startApp();}, child:Text("START",style: TextStyle(color: Colors.white),)):TextButton(
              onPressed: () {
                pageController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text(
                      "NEXT",
                style: TextStyle(color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget onBoardPages(int num) => Container(
        color: Colors.blueAccent,
        child: Center(
            child: Text(
          onboardScreenList[num],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
          ),
        )),
      );

  void startApp()async{
    var sharedPreference=await SharedPreferences.getInstance();
    sharedPreference.setBool("ShowOnBoardingScreen", false);
    SharedPreferenceClass.sharedPreferenceClassInstance.canShowOnBoredScreen=false;
    Navigator.pushReplacementNamed(context, RouteGenerator.HOME_SCREEN);
  }
}
