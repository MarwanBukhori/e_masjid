import 'package:flutter/material.dart';
import 'package:e_masjid/widgets/widgets.dart';
import 'package:e_masjid/utils/constants.dart';

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
        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: kPrimaryColor),

      ),
      backgroundColor: kPrimaryColor,
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
                      text: const TextSpan(
                          text: "Hi, Marwan",
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
                  Icon(
                    Icons.menu,
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
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
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
      ),
    );
  }

  static const List<Choice> choices = const <Choice>[
    const Choice(
        title: 'Tanya Imam',
        icon: Icons.question_answer,
        cardColor: Colors.yellow,
        iconColor: kPrimaryColor),
    const Choice(
        title: 'Mohon Nikah',
        icon: Icons.contacts,
        cardColor: Colors.yellow,
        iconColor: kPrimaryColor),
    const Choice(
        title: 'Tempah Qurban',
        icon: Icons.map,
        cardColor: Colors.yellow,
        iconColor: kPrimaryColor),
    const Choice(
        title: 'Jadual Program',
        icon: Icons.calendar_today,
        cardColor: Colors.yellow,
        iconColor: kPrimaryColor),
    const Choice(
        title: 'Sumbangan',
        icon: Icons.monetization_on,
        cardColor: Colors.yellow,
        iconColor: kPrimaryColor),
    const Choice(
        title: 'Semak Status',
        icon: Icons.settings,
        cardColor: Colors.yellow,
        iconColor: kPrimaryColor),
    const Choice(
        title: 'Al-Quran',
        icon: Icons.book_rounded,
        cardColor: Colors.yellow,
        iconColor: kPrimaryColor),
    const Choice(
        title: 'Hadis 40',
        icon: Icons.wifi,
        cardColor: Colors.yellow,
        iconColor: kPrimaryColor),
    const Choice(
        title: 'Doa Harian',
        icon: Icons.wifi,
        cardColor: Colors.yellow,
        iconColor: kPrimaryColor),
  ];
}

class Choice {
  const Choice(
      {required this.title,
      required this.icon,
      required this.cardColor,
      required this.iconColor});

  final String title;
  final IconData icon;
  final Color cardColor;
  final Color iconColor;
}

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
        elevation: 8,
        color: Colors.white,
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  choice.icon,
                  color: choice.iconColor,
                  size: 36,
                ),
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
        ));
  }
}
