import 'package:flutter/material.dart';
import 'package:sivigila/Admin/Widgets/categorias.dart';

class Casosfallidos extends StatefulWidget {
  const Casosfallidos({super.key});

  @override
  State<Casosfallidos> createState() => _CasosfallidosState();
}

class _CasosfallidosState extends State<Casosfallidos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Casos fallidos",
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
