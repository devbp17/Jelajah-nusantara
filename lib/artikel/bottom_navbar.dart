import 'package:flutter/material.dart';
import 'package:jelajah_nusantara/artikel/artikel_screen.dart';
import 'package:jelajah_nusantara/screens/auth/profile_screen.dart';
import 'package:jelajah_nusantara/screens/home/home.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;
  List<Widget> get _pages => [
    Home(),
    ArtikelScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        child: BottomNavigationBar(
          backgroundColor: Color(0XFFD1A824),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Artikel Saya'),
            BottomNavigationBarItem(icon: Icon(Icons.person_2_rounded),label: 'Profile')
          ]),
      ),
    );
  }
}
