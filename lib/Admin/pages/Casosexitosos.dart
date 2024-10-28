import 'package:flutter/material.dart';
import 'package:sivigila/Admin/Widgets/categorias.dart';

class Casosexitosos extends StatefulWidget {
  const Casosexitosos({super.key});

  @override
  State<Casosexitosos> createState() => _CasosexitososState();
}

class _CasosexitososState extends State<Casosexitosos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Casos exitosos",
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
<<<<<<< HEAD
              onSelectionChanged: (String? categoria, String? subcategoria) {
                if (categoria == null && subcategoria == null) {
                  // Mostrar todos los casos
                } else {
                  // Filtrar los casos por categoría y subcategoría
                  print(categoria);
                  print(subcategoria);
=======
              onSelectionChanged: (String? categoria, String? subcategoria,
                  String? subsubcategoria) {
                if (categoria == null &&
                    subcategoria == null &&
                    subsubcategoria == null) {
                  // Mostrar todos los casos
                } else {
                  // Filtrar los casos por categoría, subcategoría y sub-subcategoría
                  print(categoria);
                  print(subcategoria);
                  print(subsubcategoria);
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
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
