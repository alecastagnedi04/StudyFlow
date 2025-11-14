import 'package:flutter/material.dart';
import 'dart:async'; // serve per il timer
import 'widgets/pomodoro_buttons.dart';  //i widgets creati separatamente
import 'widgets/pomodoro_shape.dart';
import 'widgets/subj_list.dart';

class TimerPage extends StatefulWidget {  // deve ricordare a che punto sta il timer
  const TimerPage({super.key});
  
  @override
  State<TimerPage> createState() => _TimerState();  // _ indica che è una classe privata
} //dico che lo stato di TimerPAge viene gestito dalla classe TimerState

// gestione stato timer, i secondi rimaneti, la pogica della pausa e riavvio, ecc.
class _TimerState extends State<TimerPage> { // eredita tutto da TimerPage (NECESSARIO)
  // static const int _tempoTotaleInSecondi=3600 se voglio un timer da 60 minuti e non voglio che sia l'unica opzione (const), ho un'unico timer globale (static)
  int _minutiSelezionati=25;
  late int _durataInSecondi; // late indica che non può essere null
  late int _secondiRimanenti; // alla fine i secondi rimanenti sono 0 non null
  bool _attivo = false;
  Timer? _timer; // il ? indica che può essere null (timer fermo)

  @override
  void initState() {
    super.initState();
    // Imposta il timer iniziale 
    _durataInSecondi = _minutiSelezionati * 60;
    _secondiRimanenti = _durataInSecondi;
  }

  //funzione chiamata dai pulsanti della durata (25,60,90)
  void _selezionaDurata(int minuti) {
    if (_attivo) {
      // non può essere cambiato mente è in funzione
      return;
    }

    // se modoifico la durata allora modifico lo stato
    setState(() {
      _minutiSelezionati = minuti;
      _durataInSecondi = minuti * 60;
      _secondiRimanenti = _durataInSecondi; // Resetta anche i secondi
    //setState non prende più di un parametro quindi gli passo una funzione che lasci () e il suo codice tra le {} diventa il suo parametro

    //la funzione seleziona durata non contiene effettivamente la durata, quello è il compito del bottone che imposto per chiamare la funzione e gli passa come parametro la durata corrispondente
    });//setState
  } //selezioneDurata


  //funzione chamata dai pulsanti stop/avvia
  void _avviaPausa() {
    if(_attivo) {
      _timer?.cancel();

    //ferma timer
    setState(() {
      _attivo=false;
    });
    }//if

    //avvia timer
    else{ 
      setState(() {
        _attivo=true;
      });
      //countdown
      _timer=Timer.periodic(const Duration(seconds: 1), (timer){
        if(_secondiRimanenti>0){
          setState(() {
            _secondiRimanenti--;
          });
        }
        else{
          _timer?.cancel();
          _resetTimer(); // funzione separata
        }
      });
    }//else1
  }//avviaPausa

  void _resetTimer(){
    _timer?.cancel();
    setState(() {
      _secondiRimanenti=_durataInSecondi;
      _attivo=false;
    });
  }

  //per far apparire le modifiche che abbiamo imposto, nel widget esterno decido solo la forma/aspetto 
  String _formattaTempo(int secondi) {
    final minuti = (secondi ~/ 60).toString().padLeft(2, '0');
    final secondiRimanenti = (secondi % 60).toString().padLeft(2, '0');
    return '$minuti:$secondiRimanenti';
  }

  double _calcolaProgresso() {
  if (_durataInSecondi == 0) return 1.0; // Evita divisione per zero
  return (_durataInSecondi - _secondiRimanenti) / _durataInSecondi;
  }

  // --- 3. IL DISEGNO (UI) ---
  // il buid va nel setState(), mentre i widgets che usa sono esterni
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // --- ECCO LA PARTE MANCANTE ---
            // MATTONCINO 1: Il display del timer
            // Usiamo il widget "stupido" e gli passiamo la stringa
            // formattata prendendo i secondi dallo stato.
            PomodoroShape(
              tempoFormattato: _formattaTempo(_secondiRimanenti),
              progresso: _calcolaProgresso(),
            ),
            const SizedBox(height: 20),
          
            // --- FINE AGGIUNTA ---


            // MATTONCINO 2: I pulsanti di controllo
            // (Ne hai messo uno doppio, ne basta uno)
            PomodoroButtons(
              attivo: _attivo,
              onAvviaPausa: _avviaPausa,
              onReset: _resetTimer,
            ),
            const SizedBox(height: 20),


            // MATTONCINO 3: La lista materie
            const SubjectList(),  //widget esterno
            
          ],
        ),
      ),
    );
  }

} // _TimerState

  //nota: ogni volta che cambio qualcosa all'interno di una variabile, 
  //se voglio che questo cambiamento appaia sullo schermo, 
  //devo usare setState((){})
