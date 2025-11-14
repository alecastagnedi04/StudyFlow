import 'package:flutter/material.dart';
import 'timer/timer_page.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainScreenState();
}

class _MainScreenState extends State<Mainpage> {
  // 1. Variabile che traccia l'indice della pagina selezionata (inizia da 0)
  int _indiceCorrente = 0; 

  // 2. Lista dei widget/pagine da visualizzare
  final List<Widget> _pagine = [
    // Indice 0: La tua TimerPage
    const TimerPage(),
    
    // Indice 1: Una pagina placeholder per esempio "Statistiche"
    const Center(child: Text('Statistiche (Da implementare)', style: TextStyle(fontSize: 24))),
    
    // Indice 2: Una pagina placeholder per esempio "Profilo"
    const Center(child: Text('Profilo (Da implementare)', style: TextStyle(fontSize: 24))),
  ];

  // 3. Funzione chiamata quando si clicca un elemento del BottomNavigationBar
  void _selezionaPagina(int index) {
    setState(() {
      _indiceCorrente = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Non usiamo l'AppBar qui (la togliamo)

      // Il body mostra la pagina selezionata in base all'indice
      body: _pagine[_indiceCorrente], 
      
      // La barra di navigazione in basso
      bottomNavigationBar: BottomNavigationBar(
        // Colore di sfondo della barra
        backgroundColor: Colors.white, 
        // Colore delle icone selezionate
        selectedItemColor: Colors.deepOrange, 
        // Colore delle icone non selezionate
        unselectedItemColor: Colors.grey, 
        
        currentIndex: _indiceCorrente, // Quale elemento è attivo
        onTap: _selezionaPagina, // Chiama la funzione di cambio pagina
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_outlined),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistiche',
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