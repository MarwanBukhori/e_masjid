import 'package:flutter/material.dart';
import 'package:e_masjid/screens/screens.dart';
import 'package:e_masjid/config/constants.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            blurRadius: 20,
          ),
        ],
      ),
      child: BottomAppBar(
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
                        if (ModalRoute.of(context)?.settings.name == '/home') {
                          DoNothingAction;
                        } else {
                          // Navigator.of(context).pop();
                          Navigator.pushNamedAndRemoveUntil(context, '/home', (_)=> false); //bukak new screen
                          // Navigator.pushAndRemoveUntil; //remove previous
                        }
                      }),
                  Text('Home',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: kPrimaryColor)),
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
                            color:kPrimaryColor,
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
                        color: kPrimaryColor,
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
                            color: kPrimaryColor,
                          )),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
