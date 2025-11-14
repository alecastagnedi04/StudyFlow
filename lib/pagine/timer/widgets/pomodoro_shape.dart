import 'package:flutter/material.dart';


class PomodoroShape extends StatelessWidget {
  final String tempoFormattato;
  final double progresso; // Nuova proprietà: percentuale di progresso (da 0.0 a 1.0)

  const PomodoroShape({
    super.key,
    required this.tempoFormattato,
    required this.progresso, // Ora è obbligatorio
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, 
      height: 100, 
      child: Stack(
        alignment: Alignment.center, // Centra i children nello stack
        children: [
          // Il cerchio di progresso
         
          // Il testo del timer (il tuo widget esistente)
          Text(
            tempoFormattato,
            style: const TextStyle(
              fontSize: 60, // Ridotto leggermente per adattarsi al cerchio
              fontWeight: FontWeight.bold,
            ),
          ),
          // Puoi aggiungere altri testi qui sotto il timer se vuoi, come "7h planned"
         
        ],
      ),
    );
  }
}