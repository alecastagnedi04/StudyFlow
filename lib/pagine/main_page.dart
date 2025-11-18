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
  static const Color primaryOrange = Color.fromARGB(255, 255, 186, 122); 
  
  // Iniziamo con Home attiva (FAB)
  int _currentIndex = 0; // Indice della pagina laterale attiva
  bool _isHomeActive = true; // Traccia se la HomePage (FAB) è attiva

  // LISTA PAGINE: Solo le pagine laterali (4 elementi)
  final List<Widget> _pages = const [
    CalendarioPage(),  // Pagina 0 (Left slot 0)
    StatsPage(),       // Pagina 1 (Left slot 1)
    MoodPage(),        // Pagina 2 (Right slot 3)
    NotesPage(),       // Pagina 3 (Right slot 4)
  ];
  
  // Funzione per aprire la ProfilePage
  void _apriProfilo() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const ProfilePage()),
    );
  }

  // LOGICA DI NAVIGAZIONE TAB LATERALE
  void _setPage(int newTapIndex) {
    if (newTapIndex == 2) return; // Ignora lo slot centrale (FAB)

    // Mappa l'indice cliccato nell'indice della lista _pages
    final int newPageIndex = newTapIndex > 2 ? newTapIndex - 1 : newTapIndex;

    setState(() {
      _currentIndex = newPageIndex; 
      _isHomeActive = false; // La Home non è più attiva
    });
  }

  // LOGICA DI NAVIGAZIONE HOME CENTRALE
  void _goToHome() {
    setState(() {
      _isHomeActive = true;
    });
  }

  // Funzione per ottenere il titolo della pagina corrente
  String _getAppBarTitle() {
    if (_isHomeActive) return 'Home';
    
    switch (_currentIndex) {
      case 0:
        return 'Calendario';
      case 1:
        return 'Statistiche';
      case 2:
        return 'Umore';
      case 3:
        return 'Note';
      default:
        return 'StudyFlow';
    }
  }
  


  // FUNZIONE CHE RESTITUISCE IL WIDGET CORRENTE (Home o Pagina Laterale)
  Widget _getCurrentPage() {
    // Il padding compensa lo spazio occupato dal BottomAppBar
      return _isHomeActive ? const HomePage() : _pages[_currentIndex];
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // APPBAR TRASPARENTE con accesso al Profilo
      appBar: AppBar(
        title: Text(_getAppBarTitle(), style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 1, 
        backgroundColor: Colors.transparent,
        foregroundColor: primaryOrange,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: _apriProfilo,
            color: primaryOrange,
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: _getCurrentPage(),
      
      // FLOATING ACTION BUTTON (il pulsante Home centrale)
      floatingActionButton: FloatingActionButton(
        onPressed: _goToHome,
        backgroundColor: primaryOrange,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        elevation: 8,
        child: const Icon(Icons.home, size: 20),
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), 
        notchMargin: 6.0,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          
          // L'indice selezionato è -1 se Home è attiva, altrimenti è l'indice della pagina laterale
          currentIndex: _isHomeActive ? 0 : _currentIndex,
          
          showSelectedLabels: false, 
          showUnselectedLabels: false,
          selectedItemColor: _isHomeActive ? Colors.grey : primaryOrange,
          unselectedItemColor: Colors.grey,
          onTap: _setPage,
          items: const [
            // Gruppo Sinistro
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendario'), // Index 0 -> Pagina 0
            BottomNavigationBarItem(icon: Icon(Icons.insights), label: 'Statistiche'),   // Index 1 -> Pagina 1

            // Slot Vuoto (Centro)
            BottomNavigationBarItem(icon: Icon(null), label: ''), // Icona nulla
            
            // Gruppo Destro
            BottomNavigationBarItem(icon: Icon(Icons.mood), label: 'Umore'),  // Index 3 -> Pagina 2
            BottomNavigationBarItem(icon: Icon(Icons.edit_note), label: 'Note'),  // Index 4 -> Pagina 3
          ],
        ),
      ),
    );
  }
}