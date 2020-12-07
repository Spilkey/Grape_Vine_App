import 'package:final_project/models/post_model.dart';
import 'package:final_project/models/user_settings.dart';
import 'package:final_project/models/user_settings_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:final_project/models/local_storage.dart';
import 'package:flutter/material.dart';
import 'views/map_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';

import 'components/bottom_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //UserSettingsModel.initUserSettings(); <-- local databse
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
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
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
        home: MyHomePage(title: 'Flutter Demo Home Page'),
        routes: <String, WidgetBuilder>{
          '/mapPage': (BuildContext context) => MapPage()
        });
  }
}
