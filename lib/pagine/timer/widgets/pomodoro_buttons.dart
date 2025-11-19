import 'package:flutter/material.dart';

class PomodoroButtons extends StatelessWidget {
  final bool attivo;
  final VoidCallback onAvviaPausa;
  final VoidCallback onReset;

  const PomodoroButtons({
    super.key,
    required this.attivo,
    required this.onAvviaPausa,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryOrange = Color.fromARGB(255, 255, 186, 122);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Tasto Reset (piccolo a sinistra)
        IconButton(
          iconSize: 30,
          onPressed: onReset,
          icon: const Icon(Icons.refresh),
          color: Colors.grey,
          tooltip: 'Reset Timer',
        ),
        
        const SizedBox(width: 20),

        // Tasto Principale (Play/Pausa)
        ElevatedButton(
          onPressed: onAvviaPausa,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryOrange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 5,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(attivo ? Icons.pause : Icons.play_arrow, size: 28),
              const SizedBox(width: 8),
              Text(
                attivo ? "PAUSA" : "AVVIA",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        
        // Spazio vuoto per bilanciare visivamente il tasto reset
        const SizedBox(width: 50), 
      ],
    );
  }
}