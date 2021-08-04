import 'package:myprofit_employee/provider/NavigationService.dart';
import 'package:myprofit_employee/src/ui/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

NavigationService navigationService = NavigationService();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String? daa = "";
  // AppTranslationsDelegate _newLocaleDelegate =
  //     AppTranslationsDelegate(newLocale: Locale("en", ""));

  @override
  Widget build(BuildContext context) {
    const MaterialColor themeColor = const MaterialColor(
      0xFF6657f4,
      const <int, Color>{
        50: const Color(0xFF6657f4),
        100: const Color(0xFF6657f4),
        200: const Color(0xFF6657f4),
        300: const Color(0xFF6657f4),
        400: const Color(0xFF6657f4),
        500: const Color(0xFF6657f4),
        600: const Color(0xFF6657f4),
        700: const Color(0xFF6657f4),
        800: const Color(0xFF6657f4),
        900: const Color(0xFF6657f4),
      },
    );

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      // statusBarColor is used to set Status bar color in Android devices.
      statusBarColor: Color(0xff493ad6),

      // To make Status bar icons color white in Android devices.
      statusBarIconBrightness: Brightness.light,

      // statusBarBrightness is used to set Status bar icon color in iOS.
      statusBarBrightness: Brightness.light,
      // Here light means dark color Status bar icons.
    ));

    return MaterialApp(
      title: 'My Profit Employee',
      navigatorKey: navigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: themeColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: GoogleFonts.openSans().fontFamily,
        // fontFamily: TextStyle().fontFamily,
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
        ),
      ),

      home: Splash(),

      // localizationsDelegates: [
      //   _newLocaleDelegate,
      //provides localised strings
      // GlobalMaterialLocalizations.delegate,
      //provides RTL support
      // GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   const Locale("en", ""),
      //   const Locale("hi", ""),
      // ],
    );
  }

//  void onLocaleChange(Locale locale) {
//     print("${locale}");
//      setState(() {
//       // _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
//     });
//   }

  // init() async {
  //   var lang = await SharedPref.getStringPreference(SharedPref.SELECTEDLANG);
  //   print("${lang}");
  //   //_newLocaleDelegate = AppTranslationsDelegate(
  //   //   newLocale: Locale(lang.isEmpty ? "en" : lang, ""));
  //   setState(() {});
  //   application.onLocaleChanged = onLocaleChange;
  // }
}
