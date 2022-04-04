import 'package:flutter/material.dart';
import 'package:e_masjid/config/constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      title: Center(
            child: Text(title,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Colors.white,
                    )),
          ),
      iconTheme: IconThemeData(color: Colors.white),

    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(75.0);
}
