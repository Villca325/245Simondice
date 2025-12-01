import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simondice_proy/controller/switch.dart';

class DevsView extends StatelessWidget {
  const DevsView({super.key});


  @override
  Widget build(BuildContext context) {
    final palanca =  Provider.of<ControladorPalanca>(context);
    return Scaffold(
      backgroundColor: mostrarColorDeFondo(palanca.modoOscuro),
      body: Column(
        children: [

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
          const SizedBox(height: 5),
          Column(
            children:[
            Row(
                mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  alignment: Alignment.center,
                    width: 190,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255,230, 230, 230),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Text("Eliseo Condori\n programador",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),
                ),
                SizedBox(width: 5),
                Container(
                  alignment: Alignment.center,
                  width: 190,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255,230, 230, 230),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Text("Joel Flores\nUI Designer",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
                )
              ]
            ),
              SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 190,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255,230, 230, 230),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Text("Hernan Laruta\n Desarrollador",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                    SizedBox(width: 5),
                    Container(
                      alignment: Alignment.center,
                      width: 190,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255,230, 230, 230),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Text("Dylan Salazar\n Desarrollador",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    )
                  ]

              ),
              SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 190,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255,230, 230, 230),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Text("Franco Villavicencio\n   \t Desarrollador",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                    SizedBox(width: 5),
                    Container(
                      alignment: Alignment.center,
                      width: 190,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255,230, 230, 230),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Text("Randol Villca\nDesarrollador",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                    )
                  ]

              ),
            ]


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
