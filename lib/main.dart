import 'package:flutter/material.dart';
import 'pagine/login.dart'; // Importa la LoginPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisco il colore principale in un solo posto
    const Color primaryOrange = Color.fromARGB(255, 216, 141, 71);

    return MaterialApp(
      title: 'StudyFlow',
      debugShowCheckedModeBanner: false, // Rimuove il banner di debug
      theme: ThemeData(
        // Tema Material 3
        useMaterial3: true,
        // Colori principali dell'app
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryOrange, // Usiamo il tuo colore arancione come base
          primary: const Color.fromARGB(255, 239, 138, 43),
          secondary: const Color.fromARGB(255, 122, 190, 255), // Un azzurro/blu
        ),
        // Stile per i testi, usiamo un font semplice
        textTheme: const TextTheme(
          // Puoi personalizzare gli stili qui
        ),
      ),
      // L'app inizia dalla schermata di Login
      home: const LoginPage(),
    );
  }
}
