import 'package:flutter/material.dart';
import 'dart:async'; // serve per il timer
import 'pomodoro_buttons.dart';  //i widgets creati separatamente
import 'pomodoro_shape.dart';
import 'subj_list.dart';
import 'bottoni_durata.dart';

class TimerPage extends StatefulWidget {  // deve ricordare a che punto sta il timer
  const TimerPage({super.key});
  
  @override
  State<TimerPage> createState() => _TimerState();  // _ indica che è una classe privata
} //dico che lo stato di TimerPAge viene gestito dalla classe TimerState

// gestione stato timer, i secondi rimaneti, la pogica della pausa e riavvio, ecc.
class _TimerState extends State<TimerPage> { // eredita tutto da TimerPage (NECESSARIO)
  // static const int _tempoTotaleInSecondi=3600 se voglio un timer da 60 minuti e non voglio che sia l'unica opzione (const), ho un'unico timer globale (static)
  String? _materiaSelezionata;
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

  void _selezioneMateria(String materia) {
    setState(() {
      // Logic: se clicchi sulla stessa materia, la deseleziona (toggle)
      _materiaSelezionata = (_materiaSelezionata == materia) ? null : materia;
    });
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


 @override
    void dispose() {
        // ✅ SOLUZIONE: Annulla il timer per evitare che chiami setState su un widget inesistente
        _timer?.cancel(); 
        super.dispose();
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
  // ... (omesso codice precedente nella classe _TimerState) ...

// --- 3. IL DISEGNO (UI) ---
@override
Widget build(BuildContext context) {
  
  // Colore principale (per l'AppBar)
  const Color primaryOrange = Color.fromARGB(255, 255, 186, 122); 
  
  return Scaffold(
    // ✅ NUOVA AGGIUNTA: AppBar con pulsante Indietro automatico
    appBar: AppBar(
      title: Text(
        // Mostra la materia selezionata o un titolo generico
        _materiaSelezionata ?? 'Timer Pomodoro',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      foregroundColor: primaryOrange,
      elevation: 1, // Leggera linea per separare dal corpo
      centerTitle: true,
      automaticallyImplyLeading: true, // Questo aggiunge la freccia Indietro
    ),
    
    // Usiamo SingleChildScrollView per evitare overflow quando si aggiungono widget
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), // Aggiunge padding laterale
        child: SizedBox(
          // Forziamo l'altezza minima a quella dello schermo meno l'AppBar
          height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top,
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Inizia dall'alto
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              
              // 1. Pulsanti Durata (Spostati in alto)
              const SizedBox(height: 30),
              DurationButtonsBox(
                  minutiSelezionati: _minutiSelezionati,
                  onDurationSelected: _selezionaDurata,
              ),
              const SizedBox(height: 50),

              // 2. Display del Timer (Al centro)
              PomodoroShape(
                tempoFormattato: _formattaTempo(_secondiRimanenti),
                progresso: _calcolaProgresso(),
              ),
              const SizedBox(height: 40),

              // 3. Pulsanti di Controllo
              PomodoroButtons(
                attivo: _attivo,
                onAvviaPausa: _avviaPausa,
                onReset: _resetTimer,
              ),
              
              // 4. SPACER: Assorbe lo spazio e spinge in basso il riquadro materie
              const Spacer(), 

              // 5. Riquadro Materie (In fondo)
              SubjectList(
                  selectedSubject: _materiaSelezionata, 
                  onSubjectSelected: _selezioneMateria,
              ),
              const SizedBox(height: 20), // Margine finale
              
            ],
          ),
        ),
      ),
    ),
  );
}



} // _TimerState

  //nota: ogni volta che cambio qualcosa all'interno di una variabile, 
  //se voglio che questo cambiamento appaia sullo schermo, 
  //devo usare setState((){})
