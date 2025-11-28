import 'package:flutter/material.dart';

class RulesView extends StatelessWidget {
  const RulesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Fondo oscuro
      appBar: AppBar(
        title: const Text('Cómo Jugar'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        // NOTA: Flutter agrega automáticamente la flecha de atrás aquí
        // si vienes de otra pantalla.
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinear texto a la izquierda
          children: [
            const Text(
              'Reglas de Simón Dice',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Lista de Reglas
            _buildRuleItem(
              1,
              "Memoriza la secuencia de colores que se iluminan.",
            ),
            _buildRuleItem(
              2,
              "Repite la secuencia tocando los botones en el mismo orden.",
            ),
            _buildRuleItem(3, "La secuencia se hace más larga en cada ronda."),
            _buildRuleItem(4, "Si te equivocas una vez, ¡Pierdes!"),

            const Spacer(), // Empuja el botón hacia abajo
            // --- BOTÓN PERSONALIZADO DE ATRÁS ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text("ENTENDIDO, VOLVER AL MENÚ"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                  // LÓGICA DEL BOTÓN ATRÁS
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper para dibujar cada regla bonita
  Widget _buildRuleItem(int number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.deepPurpleAccent,
            child: Text(
              "$number",
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
