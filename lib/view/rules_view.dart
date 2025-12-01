import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simondice_proy/controller/switch.dart';

class RulesView extends StatelessWidget {
  const RulesView({super.key});
  @override
  Widget build(BuildContext context) {
    final palanca=Provider.of<ControladorPalanca>(context);
    return Scaffold(
      backgroundColor: mostrarColorDeFondo(palanca.modoOscuro), // Fondo oscuro
      appBar: AppBar(
        title: const Text('Cómo Jugar'),
        backgroundColor: mostrarColorDeFondo(palanca.modoOscuro),
        foregroundColor: mostrarColorTexto(palanca.modoOscuro),
        // NOTA: Flutter agrega automáticamente la flecha de atrás aquí
        // si vienes de otra pantalla.
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinear texto a la izquierda
          children: [
            Text(
              'Reglas de Simón Dice',
              style: TextStyle(
                color: mostrarColorTexto(palanca.modoOscuro),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Lista de Reglas
            _buildRuleItem(
              1,
              "Memoriza la secuencia de colores que se iluminan.", context
            ),
            _buildRuleItem(
              2,
              "Repite la secuencia tocando los botones en el mismo orden.", context
            ),
            _buildRuleItem(3, "La secuencia se hace más larga en cada ronda.",context),
            _buildRuleItem(4, "Si te equivocas una vez, ¡Pierdes!",context),

            const Spacer(), // Empuja el botón hacia abajo
            // --- BOTÓN PERSONALIZADO DE ATRÁS ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text("ENTENDIDO, VOLVER AL MENÚ"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: mostrarColorDeFondo(palanca.modoOscuro),
                  foregroundColor: mostrarColorTexto(palanca.modoOscuro),
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
  Widget _buildRuleItem(int number, String text, BuildContext context) {
    final palanca=Provider.of<ControladorPalanca>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: mostrarColorDeFondo(!palanca.modoOscuro),
            child: Text(
              "$number",
              style: TextStyle(fontSize: 12, color: mostrarColorTexto(!palanca.modoOscuro)),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: mostrarColorTexto(palanca.modoOscuro), fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
  Color mostrarColorDeFondo(bool valor){
      if(valor == true)
        return Color.fromARGB(255, 0, 0, 0);
      else
        return Color.fromARGB(255, 245, 245, 245);
  }
  Color mostrarColorTexto(bool valor){
    if(valor == true)
      return Color.fromARGB(255,245, 245, 245);
    else
      return Color.fromARGB(255, 0, 0, 0);
  }
}
