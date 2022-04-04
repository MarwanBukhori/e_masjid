import 'package:e_masjid/providers/auth_service.dart';
import 'package:e_masjid/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:e_masjid/screens/screens.dart';
import 'config/app_router.dart';
import 'config/theme.dart';
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
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
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
          '/': (context)=>   Wrapper(),
        },
      ),
    );
  }
}