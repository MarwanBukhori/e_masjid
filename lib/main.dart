import 'package:flutter/material.dart';
import 'package:e_masjid/screens/screens.dart';
import 'config/app_router.dart';
import 'config/theme.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Masjid',
      theme: theme(),
       // home: LoginScreen(),
      // home: ProgramScreen(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: HomeScreen.routeName,


    );
  }
}