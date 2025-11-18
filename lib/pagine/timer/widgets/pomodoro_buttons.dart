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
    const Size buttonSize = Size(120, 50);
    const TextStyle buttonTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Pulsante AVVIA/PAUSA
        ElevatedButton(
          
          onPressed: onAvviaPausa, // Chiama la funzione passata dal "Cervello"
          style: ElevatedButton.styleFrom(
            minimumSize: buttonSize,
            backgroundColor: attivo ? const Color.fromARGB(255, 255, 186, 122):const Color.fromARGB(255, 249, 159, 75) ,
            foregroundColor: Colors.white,
          ),
          child: Text(attivo ? 'Pausa' : 'Avvia', 
            style: buttonTextStyle,
          ),
        ),
        const SizedBox(width: 30),
        
        // Pulsante RESET
        ElevatedButton(
          onPressed: onReset, // Chiama la funzione passata dal "Cervello"
          style: ElevatedButton.styleFrom(
            minimumSize: buttonSize,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          child: const Text('Reset',style: buttonTextStyle,),
        ),
      ],
    );
  }
}