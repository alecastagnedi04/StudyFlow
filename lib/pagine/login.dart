import 'package:flutter/material.dart';
import 'main_page.dart'; // Assicuriamoci che il nome del file sia questo

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _vaiAllaMainPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => const MainPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryOrange = Color.fromARGB(255, 255, 186, 122);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 244, 189, 153),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(width: 10),
                  Text(
                    'StudyFlow',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 50, 50, 50),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Concentrazione e produttività, a portata di mano.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 80),

              ElevatedButton.icon(
                onPressed: () {
                  // Per ora entriamo direttamente nella main
                  _vaiAllaMainPage(context);
                },
                icon: const Icon(Icons.person, color: Colors.white),
                label: const Text(
                  'Entra con Google',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(280, 55),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
              ),
              const SizedBox(height: 20),

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
