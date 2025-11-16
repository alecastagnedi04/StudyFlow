import 'package:flutter/material.dart';
import 'MainPage.dart'; // Assumo che MainPage.dart sia nella stessa directory 'pagine'

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _vaiAllaMainPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => const Mainpage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Definiamo i colori del gradiente coerenti col tuo tema
    const Color primaryOrange = Color.fromARGB(255, 255, 186, 122);
    // MODIFICA QUI: Uso un arancione più saturo e visibile per il gradiente
    const Color visiblePeach = Color.fromARGB(255, 255, 209, 178); // Un tono più scuro di pesca

    return Scaffold(
      body: Container(
        // Aggiunge il gradiente di sfondo a tutto il container
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // Ora parte da un colore più scuro e sfuma verso il bianco
            colors: [Color.fromARGB(255, 244, 189, 153), Colors.white], // Da pesca più visibile a bianco
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // --- 1. Logo e Titolo ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icona che simboleggia il "flusso" o "studio"
                  const Icon(
                    Icons.bubble_chart_sharp, // Simbolo di "flusso" o "concentrazione"
                    size: 55,
                    color: primaryOrange,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'StudyFlow',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 50, 50, 50), // Colore scuro per contrasto
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Slogan
              const Text(
                'Concentrazione e produttività, a portata di mano.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 80),

              // --- 2. Pulsante Entra con Google (con bordi arrotondati) ---
              ElevatedButton.icon(
                onPressed: () {
                  // Logica di autenticazione Google
                },
                icon: const Icon(Icons.person, color: Colors.white),
                label: const Text(
                  'Entra con Google',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(280, 55),
                  backgroundColor: Colors.blue, 
                  shape: RoundedRectangleBorder( // Rende i bordi arrotondati
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5, // Leggera ombra
                ),
              ),
              const SizedBox(height: 20),

              // --- 3. Pulsante Entra come Ospite (Testo Semplice) ---
              TextButton(
                onPressed: () => _vaiAllaMainPage(context),
                child: const Text(
                  'Entra come ospite',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}