import 'package:e_masjid/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';
import 'package:e_masjid/config/constants.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:e_masjid/providers/user.provider.dart';

import '../providers/user.provider.dart';
import '../services/firestore_service.dart';

class HomeScreen extends StatefulWidget {

  static const String routeName = '/home';

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
  String username = "";
  FireStoreService fireStoreService = FireStoreService();

  Widget build(BuildContext context) {

    fireStoreService.getdata().then((value) {
      username = value.data()!["name"];
      setState(() {});
    });

    final appUser = Provider.of<AppUser>(context);
    Size size = MediaQuery
        .of(context)
        .size;

    double heightFromWhiteBg = size.height - 200.0 - 70;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: kPrimaryColor),

      ),
      body: Container(
        // color: Colors.yellow,
        color: kPrimaryColor,
        height: size.height - kToolbarHeight,
        child: Stack(
          children: [
            Container(
              height: 70.0,
              // color: Colors.red,
              color: kPrimaryColor,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                      text:  TextSpan(
                          text: "Hi, $username",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: "\nStart your beautiful day",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                ))
                          ])),
                  IconButton(
                    icon: new Icon(Icons.logout_rounded),
                    onPressed: () async {

                      Widget continueButton = TextButton(
                        child: Text("Ya"),
                        onPressed: () async {
                          await appUser.signOut();
                          Navigator.pop(context);
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                      );

                      Widget cancelButton = TextButton(
                        child: Text("Tidak"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      );


                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: Text("Log Keluar"),
                        content: Text("Anda pasti mahu log keluar?"),
                        actions: [
                          continueButton,
                          cancelButton,
                        ],
                      );

                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                      // createAlertDialog(context);

                    },
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            // kotak putih
            Positioned(
              top: 95.0,
              width: size.width,
              child: Container(
                height: heightFromWhiteBg + 50,
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
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 275,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 3.0,
                  mainAxisSpacing: 8.0,
                  children: List.generate(choices.length, (index) {
                    return Center(
                      child: SelectCard(choice: choices[index]),
                    );
                  }),
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

  Widget serviceCard(Map item, String active, Function setActive) {
    bool isActive = active == item["key"];
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setActive(item["key"]);
          Future.delayed(Duration(milliseconds: 350), () {});
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: isActive ? Colors.black : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
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
      ),    );
  }

  static const List<Choice> choices = const <Choice>[
    const Choice(
        title: 'Tanya Imam',
        icon: Icons.edit_note_outlined,
        cardColor: Colors.yellow,
        iconColor: Colors.blueGrey,
        route: '/tanya'),
    const Choice(
        title: 'Mohon Nikah',
        icon: Icons.favorite,
        cardColor: Colors.yellow,
        iconColor: Colors.red,
        route: '/nikah'),
    const Choice(
        title: 'Tempah Qurban',
        icon: Icons.payment_outlined,
        cardColor: Colors.yellow,
        iconColor: Colors.orange,
        route: '/qurban'),
    const Choice(
        title: 'Jadual Program',
        icon: Icons.calendar_today,
        cardColor: Colors.yellow,
        iconColor: Colors.cyan,
        route: '/program'),
    const Choice(
        title: 'Sumbangan',
        icon: Icons.currency_bitcoin_rounded,
        cardColor: Colors.yellow,
        iconColor: Colors.yellow,
        route: '/derma'),
    const Choice(
        title: 'Semak Status',
        icon: Icons.check,
        cardColor: Colors.yellow,
        iconColor: Colors.green,
        route: '/semak'),
    const Choice(
        title: 'Al-Quran',
        icon: Icons.menu_book_outlined,
        cardColor: Colors.yellow,
        iconColor: Colors.brown,
        route: '/quran'),
    const Choice(
        title: 'Hadis 40',
        icon: Icons.note_outlined,
        cardColor: Colors.yellow,
        iconColor: Colors.teal,
        route: '/hadis'),
    const Choice(
        title: 'Doa Harian',
        icon: Icons.description_outlined,
        cardColor: Colors.yellow,
        iconColor: Colors.indigo,
        route: '/doa'),
  ];
}

class Choice {
  const Choice({required this.title,
    required this.icon,
    required this.cardColor,
    required this.iconColor,
    required this.route});

  final String title;
  final IconData icon;
  final Color cardColor;
  final Color iconColor;
  final String route;
}

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return GestureDetector(
      onTap: () =>
      {
        Navigator.pushNamed(context, choice.route) //bukak new screen
        // Navigator.pushAndRemoveUntil; //remove previous
      },
      child: Card(
          elevation: 8,
          color: Colors.white,
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // IconButton(
                  Icon(
                    choice.icon,
                    color: choice.iconColor,
                    size: 36,
                  ),
                  // onPressed: () {
                  //   if (choices[0]) {
                  //     DoNothingAction;
                  //   } else {
                  //     // Navigator.of(context).pop();
                  //     Navigator.pushNamed(context, '/'); //bukak new screen
                  //     // Navigator.pushAndRemoveUntil; //remove previous
                  //   }
                  // },
                  // ),
                  SizedBox(
                    height: 9.0,
                  ),
                  Text(
                    choice.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 13.0,
                        color: Colors.black45),
                  )
                  // Text(choice.title),
                ]),
          )),
    );
  }
}



