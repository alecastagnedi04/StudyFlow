import 'package:flutter/material.dart';

import 'home/home_page.dart';
import 'calendario/calendario_page.dart';
import 'stats/widgets/stats_page.dart';
import 'umore/mood_page.dart';
import 'note/notes_page.dart';
import 'profilo/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // Ordine tab: Home, Calendario, Statistiche, Umore, Note, Profilo
  final List<Widget> _pages = const [
    HomePage(),
    CalendarioPage(),
    StatsPage(),
    MoodPage(),
    NotesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudyFlow'),
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // necessario con 4+ voci
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: 'Statistiche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mood),
            label: 'Umore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note),
            label: 'Note',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profilo',
          ),
        ],
      ),
    );
  }
}
