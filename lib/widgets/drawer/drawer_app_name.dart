import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user.provider.dart';

class DrawerAppName extends StatelessWidget {
  const DrawerAppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "E-Masjid",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: height * 0.035,
                ),
              ),
            ),
          ],
        ),
        Image.asset('assets/images/grad_logo.png', height: height * 0.17)
      ],
    );
  }
}
