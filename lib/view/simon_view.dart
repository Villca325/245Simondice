import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simondice_proy/controller/switch.dart';
import '../controller/simon_controller.dart';

class SimonView extends StatelessWidget {
  const SimonView({super.key});
  @override
  Widget build(BuildContext context) {

    final controlador = Provider.of<Controlador>(context); //conectamos al controller
    final palanca = Provider.of<ControladorPalanca>(context);
    bool modoOscuro = palanca.modoOscuro;
      if(controlador.estado == estados.terminado)
      {
        controlador.estado = estados.espera;
        Future.microtask((){
          showDialog(context: context,  builder: (context) {
            return AlertDialog(
              title: Text('Te equivocaste!'),
              content: Text('Puntaje conseguido: ${controlador.puntaje}'),
            );
          },
          );
        });

    }


    return Scaffold(
      //titulo
      backgroundColor: mostrarColorDeFondo(modoOscuro),
      // appBar: AppBar(title: const Text("Simón Dice")),
      // PRINCIPAL
      body: SingleChildScrollView(
        child: Column(
        
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
            const SizedBox(height:50),
            Text(
              mostrarTitulo(context),
              style: TextStyle(color: mostrarColorDeTextoPorElModo(modoOscuro), fontSize: 50,fontFamily: "Arial",fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
        
        
            // --- PARTE B: El Tablero de 4 Botones ---
            // En lugar de una cuadrícula automática, usamos Filas (Rows) manuales.
        
            // FILA DE ARRIBA (Verde y Rojo)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botón 0: Verde
                _botonDeColor(context, 1, Colors.green),
                const SizedBox(width: 10),
                // Botón 1: Rojo
                _botonDeColor(context, 2, Colors.red),
              ],
            ),
            const SizedBox(height: 10),
            // FILA DE ABAJO (Amarillo y Azul)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botón 2: Azul (Nota: ajusté el orden para que cuadre visualmente)
                _botonDeColor(context, 3, Colors.blue),
                const SizedBox(width: 10),
                // Botón 3: Amarillo
                _botonDeColor(context, 4, Colors.yellow),
        
              ],
            ),
            const SizedBox(height: 50),
        
            // --- PARTE C: Botón de Jugar ---
            // Solo se muestra si NO estamos jugando actualmente
        
            if (controlador.estado == estados.espera || controlador.estado == estados.terminado) ...[
              ElevatedButton(
                onPressed: () {
                  // Le ordenamos al controller que inicie
                  controlador.iniciarJuego();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text("INICIAR JUEGO",style: TextStyle(color: Colors.white),),
              ),
        
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.info_outline,color: Colors.white,),
                label: const Text("Sobre manadaCorps", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.pushNamed(context, '/devs');
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 24),
                label: const Text("Reglas", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.pushNamed(context, '/rules');
                },
              ),
              const SizedBox(height: 40),
                Center(
                  child: Column(
                    children:[
                      Text("Modo oscuro", style: TextStyle(color:mostrarColorDeTextoPorElModo(modoOscuro))),
                      Switch(
                        value: palanca.modoOscuro,
                        onChanged: (value) {
                          palanca.palanca(value);
                        },
                      ),
                      Text("ManadaCorps © 2024 ",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      Text("Todos los derechos reservados.",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),),
        
                    ]
                  )
                  ,
                ),
        
            ],
          ],
        ),
      ),
    );

  }

  // --- PARTE D: La Fábrica de Botones ---
  // Esta función crea un cuadradito de color.
  // Recibe: el "contexto", el "número del botón" (0,1,2,3) y su "color base".


  Widget _botonDeColor(BuildContext context, int numeroBoton,  Color colorBase ){
    // Volvemos a pedir el controller para saber si ESTE botón debe brillar
    final controlador = Provider.of<Controlador>(context);


    bool estaEncendido = (controlador.luzEncendida == numeroBoton);
    return GestureDetector(
      onTap: (){
          controlador.comprobarEntrada(numeroBoton);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: mostrarColor(estaEncendido,colorBase),
            borderRadius: BorderRadius.circular(15),
            boxShadow: mostrarSombra(estaEncendido,colorBase),
        ),
      ),
    );

  }

  // MOSTRAR COLOR
  Color mostrarColorDeTextoPorElModo(bool valor){
      if(valor == true)
        return Colors.white;
      else
        return Colors.black;
  }
  Color mostrarColorDeFondo(bool valor){
    if(valor == true)
      return Color.fromARGB(255, 0, 0, 0);
    else
      return Color.fromARGB(255, 240, 240, 240);
  }

  // PUNTAJE
  String mostrarTitulo(BuildContext context){
    final controlador = Provider.of<Controlador>(context);

    if(controlador.estado == estados.espera || controlador.estado == estados.terminado)
      return "SIMÓN DICE";
    else
    {
      if(controlador.estado == estados.introducir || controlador.estado == estados.mostrando)
        return "Puntaje ${controlador.puntaje}";
      else
        return "";
    }
  }

  Color mostrarColor(bool estaEncendido, Color colorBase){
    if(estaEncendido)
      return colorBase;
    else
      return colorBase.withAlpha(76);
  }
  List<BoxShadow> mostrarSombra(bool estaEncendido, Color colorBase){
    if(estaEncendido)
      return [BoxShadow(color: colorBase, blurRadius: 20, spreadRadius: 2)];
    else
      return [];
  }
}
