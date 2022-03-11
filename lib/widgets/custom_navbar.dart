import 'package:e_masjid/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:e_masjid/screens/screens.dart';
import 'package:path/path.dart';
import 'package:e_masjid/utils/constants.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  List<Widget> tabPages = [
    HomeScreen(),
    DermaScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: kWhiteColor,
elevation: 1,
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //icon for home
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.home,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
                      if (ModalRoute.of(context)?.settings.name == '/') {
                        DoNothingAction;
                      } else {
                        // Navigator.of(context).pop();
                        Navigator.pushNamed(context, '/'); //bukak new screen
                        // Navigator.pushAndRemoveUntil; //remove previous
                      }
                    }),
                Text('Home',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: kPrimaryColor
                        )),
              ],
            ),

//icon for program
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
                      if (ModalRoute.of(context)?.settings.name == '/program') {
                        DoNothingAction;
                      } else {
                        // Navigator.of(context).pop();
                        Navigator.pushNamed(
                            context, '/program'); //bukak new screen
                        // Navigator.pushAndRemoveUntil; //remove previous
                      }
                    }),
                Text('Program',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                        )),
              ],
            ),

            //icon for derma
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (ModalRoute.of(context)?.settings.name == '/derma') {
                        DoNothingAction;
                      } else {
                        // Navigator.of(context).pop();
                        Navigator.pushNamed(
                            context, '/derma'); //bukak new screen
                        // Navigator.pushAndRemoveUntil; //remove previous
                      }
                    }),
                Text('Derma',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                        )),
              ],
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.question_answer,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (ModalRoute.of(context)?.settings.name == '/tanya') {
                        DoNothingAction;
                      } else {
                        // Navigator.of(context).pop();
                        Navigator.pushNamed(
                            context, '/tanya'); //bukak new screen
                        // Navigator.pushAndRemoveUntil; //remove previous
                      }
                    }),
                Text('Tanya',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                        )),
              ],
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (ModalRoute.of(context)?.settings.name == '/more') {
                        DoNothingAction;
                      } else {
                        // Navigator.of(context).pop();
                        Navigator.pushNamed(
                            context, '/more'); //bukak new screen
                        // Navigator.pushAndRemoveUntil; //remove previous
                      }
                    }),
                Text('More',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.white,
                        )),
              ],
            )
            // IconButton(
            //     icon: Icon(Icons.home, color: Colors.white,),
            //     onPressed: (){
            //       Navigator.pushNamed(context, '/');
            //     }),
            // IconButton(
            //     icon: Icon(Icons.home_mini, color: Colors.white),
            //     onPressed: (){
            //       Navigator.pushNamed(context, '/program');
            //     }),
            // IconButton(
            //     icon: Icon(Icons.person, color: Colors.white),
            //     onPressed: (){
            //       Navigator.pushNamed(context, '/derma');
            //     }),
            // IconButton(
            //     icon: Icon(Icons.person, color: Colors.white),
            //     onPressed: (){
            //       Navigator.pushNamed(context, '/tanya');
            //     }),
            // IconButton(
            //     icon: Icon(Icons.person, color: Colors.white),
            //     onPressed: (){
            //       Navigator.pushNamed(context, '/more');
            //     }),
          ],
        ),
      ),
    );
  }
}
