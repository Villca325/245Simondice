import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simondice_proy/controller/switch.dart';

class DevsView extends StatelessWidget {
  const DevsView({super.key});

  // Lista actualizada para manejar RUTAS DE IMÁGENES en lugar de colores
  // Asegúrate de agregar los archivos en tu carpeta assets/images/
  final List<Map<String, String>> _developers = const [
    {'name': 'Eliseo Condori', 'id': '51', 'image': 'assets/eliseo.png'},
    {'name': 'Joel Fernando', 'id': '67', 'image': 'assets/joel.png'},
    {'name': 'Hernan Laruta', 'id': '83', 'image': 'assets/hernan.png'},
    {'name': 'Dylan Salazar', 'id': '156', 'image': 'assets/dylan.png'},
    {'name': 'Franco Villavicencio', 'id': '173', 'image': 'assets/franco.png'},
    {'name': 'Randol Armando', 'id': '174', 'image': 'assets/randol.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final palanca =  Provider.of<ControladorPalanca>(context);
    return Scaffold(
      backgroundColor: mostrarColorDeFondo(palanca.modoOscuro),
      body: Column(
        children: [
          // --- 1. HEADER ---
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
              bottom: 30,
            ),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF2C2C2C),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Desarrolladores',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'App Nivel Básico',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),

          // --- 2. GRID DE TARJETAS ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: _developers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 3.75, // Proporción
                ),
                itemBuilder: (context, index) {
                  final dev = _developers[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: colorContenedorSegunModo(palanca.modoOscuro),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // --- IMAGEN ---

                          /*
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                dev['image']!,
                                fit: BoxFit
                                    .cover, // La imagen llena el espacio sin deformarse
                                width: double.infinity,
                                // ESTO ES IMPORTANTE:
                                // Si no encuentra la imagen (ej. aún no la suben), muestra un ícono gris.
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.grey[500],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),
                          */
                          // Nombre
                          Text(
                            dev['name']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          // Número / ID
                         /* Text(
                            dev['id']!,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[500],
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  );
                },
              ),
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
  Color colorContenedorSegunModo(bool valor){
    if(valor == true)
      return Color.fromARGB(255,230, 230, 230);
    else
      return Color.fromARGB(255, 255, 255, 255);
  }
}
