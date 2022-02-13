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
  final List options = [
    [
      {
        "name": "Semak Jadual",
        "icon": "assets/svg/mobile.svg",
        "key": "mobile",
      },
      {
        "name": "Derma ",
        "icon": "assets/svg/tablet.svg",
        "key": "tablet",
      },
    ],
    // Second
    [
      {
        "name": "Semak Status",
        "icon": "assets/svg/laptop.svg",
        "key": "laptop",
      },
      {
        "name": "Tanya Imam",
        "icon": "assets/svg/desktop.svg",
        "key": "desktop",
      },
    ],
    // Third
    [
      {
        "name": "Mohon Nikah",
        "icon": "assets/svg/watch.svg",
        "key": "watch",
      },
      {
        "name": "Tempah Qurban",
        "icon": "assets/svg/headphone.svg",
        "key": "headphone",
      },
    ]
  ];

  String active = "";

  void setActiveFunc(String key) {
    setState(() {
      active = key;
    });
  }

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
        height: size.height - kToolbarHeight,
        child: Stack(
          children: [
            Container(
              height: 120.0,
              color: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: FittedBox(
                child: Container(
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
                      SizedBox(
                        height: 10.0,
                      ),
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
              top: 135.0,
              width: size.width,
              child: Container(
                height: heightFromWhiteBg,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
              ),
            ),
            // kotak grid
            Positioned(
              top: 130.0,
              height: heightFromWhiteBg,
              width: size.width,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    3,
                    (index) => Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: index == 2 ? 0 : 10.0),
                        child: Row(
                          children: [
                            serviceCard(
                                options[index][0], active, setActiveFunc),
                            SizedBox(
                              width: 10.0,
                            ),
                            serviceCard(
                                options[index][1], active, setActiveFunc),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
           ],
         ),
       ),

      bottomNavigationBar: CustomNavBar(),
      // bottomNavigationBar: CustomNavBar(),
    );
  }
}

Widget serviceCard(Map item, String active, Function setActive) {
  bool isActive = active == item["key"];
  return Expanded(
    child: GestureDetector(
      onTap: () {
        setActive(item["key"]);
        Future.delayed(Duration(milliseconds: 350), () {

        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.grey,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              item["icon"],
              color: isActive ? Colors.white : null,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              item["name"],
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  color: isActive
                      ? Colors.white
                      : Color.fromRGBO(20, 20, 20, 0.96)),
            )
          ],
        ),
      ),
    ),
  );
}
