import 'package:final_project/models/colors.dart';
import 'package:final_project/models/user_data.dart';
import 'package:flutter/material.dart';

import '../views/main_feed.dart';
import '../views/discover_feed.dart';
import '../views/notifications.dart';
import '../views/profile_page.dart';

import '../app_localizations.dart';

/**
 * Top level widget under the 'MyApp' widget
 * This widget is incharge of our bottom naviagtion and any top level state we might need
 */
class NavigatorBar extends StatefulWidget {
  NavigatorBar({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  // Manually making bottom nav items as using the map function
  // would require use to manually hold icon and text data in array anyway

  int _selectedIndex = 0;

  var pages = <Widget>[
    MainFeed(),
    DiscoverFeedPage(),
    // TEMP:
    ProfilePage(
        userID: UserData.userData['user_id'],
        userImage: null,
        isFriend: true,
        isMainPage: true),
    Notifications(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // set our state onTap, in this case our current page index,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          // items: navItems,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label:
                  AppLocalizations.of(context).translate('btm_nav_home_label'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: AppLocalizations.of(context)
                  .translate('btm_nav_search_label'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: AppLocalizations.of(context).translate('btm_nav_account_label'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label:
                  AppLocalizations.of(context).translate('btm_nav_notif_label'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: SecondaryColor,
        ));
  }
}
