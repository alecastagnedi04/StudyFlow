import 'package:flutter/material.dart';

// Assicurati che questi import siano corretti nel tuo progetto
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
  
  // Indice LOGICO della pagina (0=Cal, 1=Stats, 2=Umore, 3=Note)
  int _currentIndex = 0; 
  bool _isHomeActive = true; 

  final List<Widget> _pages = const [
    CalendarioPage(),  
    StatsPage(),       
    MoodPage(),        
    NotesPage(),       
  ];
  
  void _apriProfilo() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const ProfilePage()),
    );
  }

  // Gestisce il click sulla barra di navigazione
  void _setPage(int visualIndex) {
    // Se l'utente clicca il buco centrale (indice 2), non facciamo nulla
    if (visualIndex == 2) return;

    // Mappiamo l'indice VISIVO (0,1,3,4) all'indice LOGICO delle pagine (0,1,2,3)
    // Se clicco a destra del buco (>2), sottraggo 1 per "saltare" il buco
    final int logicalIndex = visualIndex > 2 ? visualIndex - 1 : visualIndex;

    setState(() {
      _currentIndex = logicalIndex; 
      _isHomeActive = false; 
    });
  }

  void _goToHome() {
    setState(() {
      _isHomeActive = true;
    });
  }

  String _getAppBarTitle() {
    if (_isHomeActive) return 'Home';
    switch (_currentIndex) {
      case 0: return 'Calendario';
      case 1: return 'Statistiche';
      case 2: return 'Umore';
      case 3: return 'Note';
      default: return 'StudyFlow';
    }
  }

  // Converte l'indice LOGICO (0-3) in indice VISIVO (0-4 con buco al 2) per evidenziare l'icona giusta
  int _getVisualIndex() {
    if (_currentIndex >= 2) return _currentIndex + 1;
    return _currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondamentale per evitare che la tastiera rompa il layout della barra
      resizeToAvoidBottomInset: false,
      // Permette al corpo di estendersi dietro al FAB per un look più moderno
      extendBody: true, 
      
      appBar: AppBar(
        title: Text(_getAppBarTitle(), style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 1, 
        backgroundColor: Colors.transparent, // Trasparente per mostrare sfondo body
        foregroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: _apriProfilo,
            color: primaryOrange,
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: _isHomeActive ? const HomePage() : _pages[_currentIndex],
      
      // bottone home separato dalla bottomAppBar
      floatingActionButton: FloatingActionButton(
        onPressed: _goToHome,
        backgroundColor: primaryOrange,
        foregroundColor: Colors.white,
        shape: const CircleBorder(), 
        elevation: 4, // Ombra 
        child: const Icon(Icons.home, size: 28),
      ),
      
      // il bottone è inserito nell appBar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


      //NON TOCCARE CHE SI ROMPE TUTTO

      // spazio per il bottone home separato 
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), 
        notchMargin: 8.0, 
        color: const Color(0xFFFFF3E0), // Colore sfondo barra 
        elevation: 10, // Ombra della barra
        padding: EdgeInsets.zero,//Rimuove padding che crea overflow 
        height: 65, // Altezza fissa 
        clipBehavior: Clip.antiAlias, // Bordi
        
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, // Trasparente perché il colore lo da BottomAppBar
          elevation: 0, // 0 perché l'ombra la da BottomAppBar
          type: BottomNavigationBarType.fixed, // Necessario per 5 pagine
          
          // evidenzia selezione
          currentIndex: _isHomeActive ? 2 : _getVisualIndex(),
          
          // in home non evidenziare
          selectedItemColor: _isHomeActive ? Colors.transparent : primaryOrange,
          unselectedItemColor: Colors.grey,
          
          showSelectedLabels: true, 
          showUnselectedLabels: false, // Nascondiamo le etichette quando l'icona non è selezionata
          
          onTap: _setPage,
          
          items: const [
            // SINISTRA
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendario'),
            BottomNavigationBarItem(icon: Icon(Icons.insights), label: 'Stats'),

            // CENTRO: home
            BottomNavigationBarItem(
              icon: Icon(Icons.circle, color: Colors.transparent), // Icona fantasma
              label: '', 
            ),
            
            // DESTRA
            BottomNavigationBarItem(icon: Icon(Icons.mood), label: 'Umore'),
            BottomNavigationBarItem(icon: Icon(Icons.edit_note), label: 'Note'),
          ],
        ),
      ),
    );
  }
}