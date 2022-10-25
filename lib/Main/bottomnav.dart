import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thehorizonapps/Main/Kuis/screens/main_quiz.dart';
import 'package:thehorizonapps/Main/PageJelajahi/home.dart';
import 'package:thehorizonapps/Main/PageSave/KategoriSave/save.dart';
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
    Pagesave(),
    MainMenu(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/logonew1.png',
              fit: BoxFit.contain,
              height: 50,
              width: 50,
            ),
            Container(
                padding: const EdgeInsets.only(left: 1), child: Text('TheHorizon', style: GoogleFonts.imFellGreatPrimerSc(color: Colors.black),)),
          ],
        ),
        //no back button
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>   SearchPage()),
              );
            },
          ),
        ],
      ),
      body:(
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 2,
        unselectedIconTheme: IconThemeData(color: Colors.black),
        selectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Jelajahi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border_outlined),
            label: 'Simpan',
            activeIcon: Icon(Icons.bookmark),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            label: 'Kuis',
            activeIcon: Icon(Icons.quiz),
          ),
        ],
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
    );
  }
}
