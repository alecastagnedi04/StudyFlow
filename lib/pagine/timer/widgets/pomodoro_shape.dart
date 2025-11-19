import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class PomodoroShape extends StatelessWidget {
  final double valoreCorrente; 
  final double maxValore;      
  final bool interattivo;
  final String etichetta;     
  final Color colore;         
  final Function(double) onChanged; 

  const PomodoroShape({
    super.key,
    required this.valoreCorrente,
    required this.maxValore,
    required this.interattivo,
    required this.etichetta,  
    required this.colore,     
    required this.onChanged,
  });

  String _formattaSecondi(double minutiTotali) {
    int secondiTotali = (minutiTotali * 60).round();
    int min = secondiTotali ~/ 60;
    int sec = secondiTotali % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    const Color trackBeige = Color.fromARGB(255, 255, 236, 219);

    return SizedBox(
      width: 280,
      height: 280,
      child: AbsorbPointer(
        absorbing: !interattivo, 
        child: SleekCircularSlider(
          min: 0,
          max: maxValore,
          initialValue: valoreCorrente,
          
          onChange: (double value) {
            if (interattivo) {
              onChanged(value);
            }
          },

          appearance: CircularSliderAppearance(
            size: 280,
            startAngle: 270,
            angleRange: 360,
            customWidths: CustomSliderWidths(
              trackWidth: 15,
              progressBarWidth: 15,
              handlerSize: interattivo ? 20 : 0, 
              shadowWidth: 0,
            ),
            customColors: CustomSliderColors(
              trackColor: trackBeige,
              progressBarColor: colore, 
              dotColor: colore,         
              hideShadow: true,
            ),
            infoProperties: InfoProperties(
              mainLabelStyle: const TextStyle(color: Colors.transparent),
            ),
          ),
          
          innerWidget: (double value) {
            // Se interattivo (stop/imposta) -> mostra minuti interi
            // Se non interattivo (timer avviato) -> mostra mm:ss
            String testoTempo;
            if (interattivo) {
               testoTempo = "${value.toInt()}m";
            } else {
               testoTempo = _formattaSecondi(value);
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    testoTempo,
                    style: const TextStyle(
                      fontSize: 60, 
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontFamily: 'monospace'
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    etichetta, 
                    style: TextStyle(
                      fontSize: 14, 
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
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