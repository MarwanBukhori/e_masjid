import 'package:e_masjid/providers/user.provider.dart';
import 'package:e_masjid/screens/landing-page.screen.dart';
import 'package:flutter/material.dart';
import 'config/app_router.dart';
import 'config/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppUser>(create: (_) => AppUser())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Masjid',
        theme: theme(),
        // home: LoginScreen(),
        // home: ProgramScreen(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: '/',
        routes: {
          '/': (context) => LandingScreen(),
          // '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
