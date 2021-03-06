import 'package:e_masjid/models/quran/ayat/ayat.dart';
import 'package:e_masjid/providers/user.provider.dart';
import 'package:e_masjid/screens/landing-page.screen.dart';


import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'config/app_router.dart';
import 'config/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'models/quran/juzz/juz.dart';
import 'models/quran/juzz/juz_list.dart';
import 'models/quran/sajda/sajda.dart';
import 'models/quran/sajda/sajda_list.dart';
import 'models/quran/surah/surah.dart';
import 'models/quran/surah/surah_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  // hive
  await Hive.initFlutter();

  // hive adapter
  Hive.registerAdapter<Ayat>(AyatAdapter());

  Hive.registerAdapter<JuzList>(JuzListAdapter());
  Hive.registerAdapter<JuzAyahs>(JuzAyahsAdapter());

  Hive.registerAdapter<SajdaList>(SajdaListAdapter());
  Hive.registerAdapter<SajdaAyat>(SajdaAyatAdapter());

  Hive.registerAdapter<SurahsList>(SurahsListAdapter());
  Hive.registerAdapter<Surah>(SurahAdapter());

  // box
  await Hive.openBox('data');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // DarkThemeProvider darkThemeProvider = DarkThemeProvider();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(480.0, 965.3333333333334),
      builder: (BuildContext context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<AppUser>(create: (_) => AppUser())
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'E-Masjid',
            theme: theme(),
            builder: EasyLoading.init(),
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: '/',
            routes: {
              '/': (context) => LandingScreen(),
              // '/': (context) => PetugasHomeScreen(maxSlide: MediaQuery.of(context).size.width * 0.835),

            },
          ),
        );
      },

    );
  }
}
