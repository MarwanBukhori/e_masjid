import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    double heightFromWhiteBg = size.height - 200.0 - 70;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.black,
      body: Container(
        // color: Colors.yellow,
        color: Colors.black,
        height: size.height - kToolbarHeight ,
        child: Stack(
          children: [
            Container(
              height: 75.0,
              // color: Colors.red,
              color: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: FittedBox(
                child: Container(
                  // color: Colors.blue,
                  color: Colors.black,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: CircleAvatar(
                      //     backgroundImage: AssetImage("assets/images/dp.png"),
                      //   ),
                      // ),

                      Text(
                        "Hi, Marwan",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.77),
                          fontSize: 22.0,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Selamat Datang",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // kotak putih
            Positioned(
              top: 95.0,
              width: size.width,
              child: Container(
                height: heightFromWhiteBg + 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 115,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: MediaQuery.of(context).size.height - 275,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListView(
                  children: [
                    buildTitleRow("TODAY CLASSES", 3),
                    SizedBox(
                      height: 20,
                    ),
                    buildClassItem(),
                    buildClassItem(),
                    SizedBox(
                      height: 10,
                    ),
                    buildTitleRow("YOUR TASKS", 4),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(

                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          buildTaskItem(
                              3, "The Basic of Typography II", Colors.red),
                          buildTaskItem(3, "Design Psychology: Principle of...",
                              Colors.green),
                          buildTaskItem(3, "Design Psychology: Principle of...",
                              Colors.green),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),


      bottomNavigationBar: CustomNavBar(),
      // bottomNavigationBar: CustomNavBar(),
    );
  }


  //Your Task
  Container buildTaskItem(int numDays, String courseTitle, Color color) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(12),
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deadline",
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "$numDays days left",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 100,
            child: Text(
              courseTitle,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Row buildTitleRow(String title, int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
              text: title,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: "($number)",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        Text(
          "See all",
          style: TextStyle(
              fontSize: 12,
              color: Color(0XFF3E3993),
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Container buildClassItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "07:00",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "AM",
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ],
          ),
          Container(
            height: 100,
            width: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 160,
                child: Text(
                  "The Basic of Typography II",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Text(
                      "Room C1, Faculty of Art & Design Building",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                        "assets/emasjid.png"),
                    radius: 10,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Gabriel Sutton",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

}







