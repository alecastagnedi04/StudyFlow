import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class PomodoroShape extends StatelessWidget {
  final String tempoFormattato;
  final double progresso; // Valore da 0.0 a 1.0

  const PomodoroShape({
    super.key,
    required this.tempoFormattato,
    required this.progresso,
  });

  @override
  Widget build(BuildContext context) {
    // Colori del tema
    const Color primaryOrange = Color.fromARGB(255, 255, 186, 122);
    const Color trackBeige = Color.fromARGB(255, 255, 236, 219);

    // Configuriamo lo slider per essere SOLO visuale (non interattivo)
    return SizedBox(
      width: 280,
      height: 280,
      // IgnorePointer blocca i tocchi, così non si può trascinare per sbaglio
      child: IgnorePointer(
        ignoring: true, 
        child: SleekCircularSlider(
          min: 0,
          max: 1,
          initialValue: progresso, // Usa il progresso calcolato (0.0 - 1.0)
          
          appearance: CircularSliderAppearance(
            size: 280,
            startAngle: 270, // Inizia in alto
            angleRange: 360,
            customWidths: CustomSliderWidths(
              trackWidth: 15,
              progressBarWidth: 15,
              handlerSize: 0, // Nasconde il pallino (non serve se non è interattivo)
              shadowWidth: 0,
            ),
            customColors: CustomSliderColors(
              trackColor: trackBeige,
              progressBarColor: primaryOrange,
              hideShadow: true,
              dotColor: Colors.transparent,
            ),
            infoProperties: InfoProperties(
              mainLabelStyle: const TextStyle(color: Colors.transparent), // Nasconde testo default
            )
          ),
          
          // Il nostro testo centrale personalizzato
          innerWidget: (double value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tempoFormattato,
                    style: const TextStyle(
                      fontSize: 60, 
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontFamily: 'monospace'
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "FOCUS",
                    style: TextStyle(
                      fontSize: 14, 
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2.0
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}