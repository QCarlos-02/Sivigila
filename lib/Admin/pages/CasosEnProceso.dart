import 'package:flutter/material.dart';
import 'package:sivigila/Admin/Widgets/categorias.dart';

class Casosenproceso extends StatefulWidget {
  const Casosenproceso({super.key});

  @override
  State<Casosenproceso> createState() => _CasosenprocesoState();
}

class _CasosenprocesoState extends State<Casosenproceso> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Casos en proceso",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Tipos de casos"),
            const SizedBox(
              height: 20,
            ),
            CategoriaSubcategoriaWidget(
              onSelectionChanged: (String? categoria, String? subcategoria) {
                if (categoria == null && subcategoria == null) {
                  // Mostrar todos los casos
                } else {
                  // Filtrar los casos por categoría y subcategoría
                  print(categoria);
                  print(subcategoria);
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            const Text("LISTA DE CASOS"),
          ],
        ),
      ),
    );
  }
}
