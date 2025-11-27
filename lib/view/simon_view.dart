import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/simon_controller.dart';

class SimonView extends StatelessWidget {
  const SimonView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SimonController>(
      context,
    ); //conectamos al controller

    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro
      appBar: AppBar(title: const Text("Simón Dice")),

      //  PRINCIPAL
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Puntaje: ${controller.score}", // Leemos el puntaje del controller
            style: const TextStyle(color: Colors.white, fontSize: 30),
          ),

          const SizedBox(height: 20), // Espacio
          Text(
            controller.state == GameState.gameOver
                ? "¡PERDISTE!"
                : "Sigue la luz...",
            style: const TextStyle(color: Colors.grey, fontSize: 20),
          ),

          const SizedBox(height: 40),

          // --- PARTE B: El Tablero de 4 Botones ---
          // En lugar de una cuadrícula automática, usamos Filas (Rows) manuales.

          // FILA DE ARRIBA (Verde y Rojo)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón 0: Verde
              _botonDeColor(context, 0, Colors.green),
              const SizedBox(width: 10), // Separación
              // Botón 1: Rojo
              _botonDeColor(context, 1, Colors.red),
            ],
          ),

          const SizedBox(height: 10), // Separación entre filas
          // FILA DE ABAJO (Amarillo y Azul)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón 2: Azul (Nota: ajusté el orden para que cuadre visualmente)
              _botonDeColor(context, 2, Colors.blue),
              const SizedBox(width: 10),
              // Botón 3: Amarillo
              _botonDeColor(context, 3, Colors.yellow),
            ],
          ),

          const SizedBox(height: 50),

          // --- PARTE C: Botón de Jugar ---
          // Solo se muestra si NO estamos jugando actualmente
          if (controller.state == GameState.idle ||
              controller.state == GameState.gameOver)
            ElevatedButton(
              onPressed: () {
                // Le ordenamos al controller que inicie
                controller.startGame();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
              ),
              child: const Text("INICIAR JUEGO"),
            ),
          ElevatedButton.icon(
            icon: const Icon(Icons.info_outline),
            label: const Text("Sobre manadaCorps"),
            onPressed: () {
              Navigator.pushNamed(context, '/devs');
            },
          ),
        ],
      ),
    );
  }

  // --- PARTE D: La Fábrica de Botones ---
  // Esta función crea un cuadradito de color.
  // Recibe: el "contexto", el "número del botón" (0,1,2,3) y su "color base".
  Widget _botonDeColor(
    BuildContext context,
    int numeroDelBoton,
    Color colorBase,
  ) {
    // Volvemos a pedir el controller para saber si ESTE botón debe brillar
    final controller = Provider.of<SimonController>(context);

    // ¿Debe brillar?
    // Si el índice que tiene el controller coincide con ESTE botón, es TRUE.
    bool estaEncendido = (controller.activeLightIndex == numeroDelBoton);

    return GestureDetector(
      // Detectar el dedo del usuario
      onTap: () {
        controller.handleInput(numeroDelBoton);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Animación suave
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          // LA MAGIA DEL COLOR:
          // Si 'estaEncendido' es true, usamos el color normal.
          // Si es false, lo hacemos transparente/oscuro (withOpacity 0.3).
          color: estaEncendido ? colorBase : colorBase.withOpacity(0.3),

          borderRadius: BorderRadius.circular(15), // Bordes redondos
          // Si está encendido, le ponemos sombra (brillo)
          boxShadow: estaEncendido
              ? [BoxShadow(color: colorBase, blurRadius: 20, spreadRadius: 2)]
              : [],
        ),
      ),
    );
  }
}
