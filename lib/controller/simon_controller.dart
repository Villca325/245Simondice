import 'dart:async'; // Necesario para los retrasos (Future.delayed)
import 'dart:math'; // Necesario para el generador de números aleatorios (Random)
import 'package:flutter/material.dart';

 //ESTADOS DEL JUEGO
enum estados{
   espera,
   mostrando,
   introducir,
   terminado,
 }

 class Controlador extends ChangeNotifier{
   // ATRIBUTOS
   estados _estado = estados.espera;
   List <int> _listaDeSecuencia = [];
   int _puntaje = 0;
   int _luzEcendida = 0;
   int _pasoActualDelUsuario = 0;
   // METODOS
       //constructor por defecto
   estados get estado => _estado;
   int get puntaje => _puntaje;
   int get luzEncendida => _luzEcendida;

   set estado(estados value) {
     _estado = value;
   }

   Future<void> iniciarJuego() async {
     _puntaje = 0;
     _estado = estados.espera;
     notifyListeners();
     _listaDeSecuencia.clear();
     _pasoActualDelUsuario = 0;

     await siguienteRonda();
   }
    // verde = 1 ; rojo = 2 ; azul = 3 ; amarillo = 4;
   Future<void> siguienteRonda()async{
     _estado = estados.mostrando;
     _pasoActualDelUsuario = 0;

     notifyListeners();
     int nuevoColor = Random().nextInt(4) + 1;
     _listaDeSecuencia.add(nuevoColor);
     await Future.delayed(const Duration(seconds: 1));
     await reproducirSecuencia();
     _estado = estados.introducir;
   }

   Future<void> reproducirSecuencia() async{
        for(int color in _listaDeSecuencia)
        {
          print("turno: $color");
          _luzEcendida = color;
          notifyListeners();
          await Future.delayed(const Duration(milliseconds: 500));
          _luzEcendida = 0;
          notifyListeners();
          await Future.delayed(const Duration(milliseconds: 500));
        }
   }

   Future<void> comprobarEntrada(int botonPulsado) async{
      if(estado == estados.introducir)
      {
          brillarBoton(botonPulsado);
          int botonCorrecto = _listaDeSecuencia[_pasoActualDelUsuario];
          print("boton correcto: $botonCorrecto");
          print("boton pulsado: $botonPulsado");
          print("paso actual: $_pasoActualDelUsuario");
          print("lista de secuencia: $_listaDeSecuencia");
          if(botonCorrecto == botonPulsado)
          {
            _pasoActualDelUsuario++;
            if(_pasoActualDelUsuario == _listaDeSecuencia.length)
              {
                _puntaje++;
                notifyListeners();
                await Future.delayed(const Duration(milliseconds: 500));

                siguienteRonda();
                //await Future.delayed(const Duration(milliseconds: 500));
              }
          }
          else
          {
            _estado = estados.terminado;
            notifyListeners();
          }
      }
   }
   Future<void> brillarBoton(int boton) async{
      _luzEcendida = boton;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds:  500));
      _luzEcendida = 0;
      notifyListeners();
   }
 }