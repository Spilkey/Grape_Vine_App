import 'package:final_project/components/navigator_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'models/colors.dart';
import 'views/map_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:final_project/models/local_storage_model.dart';
import 'package:final_project/views/map_page.dart';
import 'package:final_project/views/splash_screen.dart';
import 'package:final_project/app_localizations.dart';
import 'package:final_project/views/create_user_page.dart';

import 'views/main_feed.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorageModel.initUserData();
  Firebase.initializeApp().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // TODO: remove before merge
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: PrimaryColor,
          primaryColorLight: SecondaryColor,
          tabBarTheme: TabBarTheme(labelColor: SecondaryColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.deepPurple,
        ),
        supportedLocales: [
          Locale('en', 'US'),
          Locale('fr', 'FR'),
          Locale('ja', 'JA')
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
        },
        home: SplashScreen(title: 'GrapeVine'),
        routes: <String, WidgetBuilder>{
          '/mapPage': (BuildContext context) => MapPage(),
          '/createUser': (BuildContext context) => CreateUserPage(),
          '/homePage': (BuildContext context) => NavigatorBar(),
          '/mainPage': (BuildContext context) => MainFeed(),
        });
  }
}
