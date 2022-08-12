import 'package:flutter/material.dart';

class AjebutterOptions extends StatelessWidget {
  AjebutterOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(
          child : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 168.0,
                      height: 64.0,
                      //)
                      decoration: BoxDecoration(color:Color.fromARGB(255, 254, 174, 0) ,borderRadius: BorderRadius.circular(4)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.settings,color: Colors.white),
                          Text("Hire",style: TextStyle(color: Colors.white)),
                          Text("Articians/Technicians",style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Container(
                      width: 168.0,
                      height: 64.0,
                      //
                      decoration: BoxDecoration(color: Color.fromARGB(255, 54, 224, 80),borderRadius: BorderRadius.circular(4)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.settings,color: Colors.white),
                          Text("Connect",style: TextStyle(color: Colors.white)),
                          Text("Professionals",style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],),
                SizedBox(height: 30.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Container(
                      width: 168.0,
                      height: 64.0,
                      decoration: BoxDecoration(color:Color.fromARGB(255, 255, 128, 57),borderRadius: BorderRadius.circular(4)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.settings,color: Colors.white),
                          Text("Locate Nearby",style: TextStyle(color: Colors.white)),
                          Text("Sundry Devices",style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    Container(
                      width: 168.0,
                      height: 64.0,
                      //
                      decoration: BoxDecoration(color:Color.fromARGB(255, 83, 35, 255) ,borderRadius: BorderRadius.circular(4)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.settings,color: Colors.white),
                          Text("Buy From",style: TextStyle(color: Colors.white)),
                          Text("Vendor",style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],),
              ],),
          ),
        )
    );
  }
}
