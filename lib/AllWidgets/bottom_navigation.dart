// import 'package:akar_icons_flutter/akar_icons_flutter.dart';

import 'package:bloodspot/pages/Maps/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../pages/home/home.dart';
import '../pages/settings/settings.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({Key key}) : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int currentIndex = 0;

  // list of screens that will be rendered in the scaffold body
  final List screens = [
    const Home(),
    const MapSample(),
    const Settings(),
  ];
  // current index

  @override
  void initState() {
    super.initState();
    // This will hide the bottom system navigation bar
    // Only the status bar on the top will show up
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: Colors.grey[100],
              gap: 2,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100],
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Request',
                ),
                // GButton(
                //   icon: LineIcons.search,
                //   text: 'Search',
                // ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: currentIndex,
              onTabChange: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}


// BottomNavigationBar(
//         currentIndex: currentIndex,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home
//                 // AkarIcons.home
//                 ),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.schedule
//                 // AkarIcons.schedule
//                 ),
//             label: 'Schedule',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings
//                 //AkarIcons.person
//                 ),
//             label: 'Account',
//           ),
//         ],
//       ),
