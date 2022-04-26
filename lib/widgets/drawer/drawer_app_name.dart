
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerAppName extends StatelessWidget {
  const DrawerAppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Transform.scale(
              scale: 1.2,
            ),
            Text(
              "\nThe",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: height * 0.025,
                color:
                    Colors.black54,
              ),
            ),
            Text(
              "E-Masjid\nApp",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:
                     Colors.black54,
                fontSize: height * 0.035,
              ),
            )
          ],
        ),
        Image.asset('assets/images/grad_logo.png', height: height * 0.17)
      ],
    );
  }
}
