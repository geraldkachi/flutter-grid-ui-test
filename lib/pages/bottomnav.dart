import 'package:flutter/material.dart';
import 'package:flutter_ui_text/pages/ExplorePage.dart';
import 'package:flutter_ui_text/pages/HistoryPage.dart';
import 'package:flutter_ui_text/pages/ProfilePage.dart';
import 'package:flutter_ui_text/pages/SearchPage.dart';
import 'package:flutter_ui_text/pages/WardrobesPage.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNaState();
}

class _BottomNaState extends State<BottomNav> {
   int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const SearchPage(),
    const HistoryPage(),
    const WardrobesPage(),
    const ExplorePage(),
    ProfilePage(),
  ];

  void _onItemTapped (int index) {
    setState(() {
    _selectedIndex = index;
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(90), topRight: Radius.circular(90))
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: BottomNavigationBar(
            backgroundColor: Colors.grey[700],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            elevation: 10,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey[400],
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.image_search), activeIcon: Icon(Icons.image_search_outlined), label: "Search"),
              BottomNavigationBarItem(icon: Icon(Icons.history), activeIcon: Icon(Icons.history_outlined), label: "History"),
              BottomNavigationBarItem(icon: Icon(Icons.water_drop_sharp), activeIcon: Icon(Icons.water_drop_sharp), label: "Wardrobes"),
              BottomNavigationBarItem(icon: Icon(Icons.explore), activeIcon: Icon(Icons.explore_outlined), label: "Explore "),
              BottomNavigationBarItem(icon: Icon(Icons.person), activeIcon: Icon(Icons.percent_outlined), label: "Profile "),
              ],
          ),
        ),
      ),
    );
  }
}