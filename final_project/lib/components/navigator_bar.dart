import 'package:flutter/material.dart';

import '../views/main_feed.dart';
import '../views/discover_feed.dart';
import '../views/notifications.dart';

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
  // TEMPORARY: moved this to the widget builder in order for internationalization to work
  //  error was that the context could not be used in an initializer

  // final navItems = <BottomNavigationBarItem>[
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.home),
  //     label: 'Home',
  //   ),
  //   BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.notifications),
  //     label: 'Notifications',
  //   )
  // ];

  int _selectedIndex = 0;

  var pages = <Widget>[
    MainFeed(),
    DiscoverFeedPage(),
    Notifications(),
    // TODO eventually add other pages here
    // Make sure if you add another page here that there is enough icons in navItems
    // you'll get an error otherwise
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
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
              label: AppLocalizations.of(context).translate('btm_nav_home_label'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: AppLocalizations.of(context).translate('btm_nav_search_label'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: AppLocalizations.of(context).translate('btm_nav_notif_label'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.purple[600],
        ));
  }
}
