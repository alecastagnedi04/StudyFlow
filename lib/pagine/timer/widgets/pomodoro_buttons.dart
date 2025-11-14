import 'package:flutter/material.dart';

// Questo widget "stupido" sa solo come disegnare
// i pulsanti Avvia/Pausa e Reset.
class PomodoroButtons extends StatelessWidget {
  final bool attivo;
  final void Function() onAvviaPausa;
  final void Function() onReset;

  const PomodoroButtons({
    super.key,
    required this.attivo,
    required this.onAvviaPausa,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Pulsante AVVIA/PAUSA
        ElevatedButton(
          onPressed: onAvviaPausa, // Chiama la funzione passata dal "Cervello"
          style: ElevatedButton.styleFrom(
            backgroundColor: attivo ? const Color.fromARGB(255, 238, 176, 83) : Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: Text(attivo ? 'Pausa' : 'Avvia'),
        ),
        const SizedBox(width: 20),

        // Pulsante RESET
        ElevatedButton(
          onPressed: onReset, // Chiama la funzione passata dal "Cervello"
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          child: const Text('Reset'),
        ),
      ],
    );
  }
}