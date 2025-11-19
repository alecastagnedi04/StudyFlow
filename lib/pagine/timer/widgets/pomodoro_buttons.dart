import 'package:flutter/material.dart';

class PomodoroButtons extends StatelessWidget {
  final bool attivo;
  final Color coloreAttivo; // ✅ NUOVO: Colore dinamico passato dal genitore
  final VoidCallback onAvviaPausa;
  final VoidCallback onReset;
  final VoidCallback onImpostazioni;

  const PomodoroButtons({
    super.key,
    required this.attivo,
    required this.coloreAttivo, // ✅ Richiesto
    required this.onAvviaPausa,
    required this.onReset,
    required this.onImpostazioni,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Tasto Reset
        IconButton(
          iconSize: 28,
          onPressed: onReset,
          icon: const Icon(Icons.refresh),
          color: Colors.grey.shade400,
          tooltip: 'Reset Timer',
        ),
        
        const SizedBox(width: 20),

        // Tasto Principale (Play/Pausa)
        ElevatedButton(
          onPressed: onAvviaPausa,
          style: ElevatedButton.styleFrom(
            backgroundColor: coloreAttivo, // ✅ Usa il colore passato (Arancione o Verde)
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 4,
            // Animazione cambio colore fluida
            animationDuration: const Duration(milliseconds: 300),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(attivo ? Icons.pause : Icons.play_arrow, size: 28),
              const SizedBox(width: 8),
              Text(
                attivo ? "PAUSA" : "AVVIA",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(width: 20),

        // Tasto Impostazioni
        IconButton(
          iconSize: 28,
          onPressed: onImpostazioni,
          icon: const Icon(Icons.settings_outlined),
          color: Colors.grey,
          tooltip: 'Impostazioni',
        ),
      ],
    );
  }
}