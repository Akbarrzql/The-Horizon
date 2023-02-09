import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/Main/Kuis/screens/main_quiz.dart';
import 'package:thehorizonapps/Main/PageJelajahi/home.dart';
import 'package:thehorizonapps/Main/PageSave/KategoriSave/saveFeed.dart';
import 'package:thehorizonapps/Main/PageSave/PageSave.dart';
import 'package:thehorizonapps/Porfile/profile.dart';
import 'package:thehorizonapps/Search/SearchPage.dart';

class MainNav extends StatefulWidget {
  const MainNav({Key? key}) : super(key: key);

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {


  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    Home(),
    PageSaveKategori(),
    MainMenu(),
    Profile(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:(
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff042330),
        elevation: 2,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white,
        unselectedIconTheme: IconThemeData(color: Colors.white),
        selectedIconTheme: IconThemeData(color: Color(0xff5FD068)),
        selectedItemColor: Color(0xff5FD068),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Color(0xff042330),
            icon: Icon(Icons.home_filled),
            label: 'Jelajahi',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xff042330),
            icon: Icon(Icons.bookmark_border_outlined),
            label: 'Simpan',
            activeIcon: Icon(Icons.bookmark, color: Color(0xff5FD068),),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xff042330),
            icon: Icon(Icons.quiz_outlined),
            label: 'Kuis',
            activeIcon: Icon(Icons.quiz, color: Color(0xff5FD068),),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xff042330),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
            activeIcon: Icon(Icons.account_circle, color: Color(0xff5FD068),),
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
    );
  }
}