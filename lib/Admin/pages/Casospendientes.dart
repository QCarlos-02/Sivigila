import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/Widgets/categorias.dart';
import 'package:sivigila/Admin/Widgets/listaReportes.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';

class Casospendientes extends StatefulWidget {
  const Casospendientes({super.key});

  @override
  State<Casospendientes> createState() => _CasospendientesState();
}

class _CasospendientesState extends State<Casospendientes> {
  @override
  Widget build(BuildContext context) {
    Reportecontroller rp = Get.find();
    rp.consultarReportesgeneral();
    print(rp.listgeneral!.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Casos pendientes",
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
            const Expanded(child: Reportes()),
          ],
        ),
      ),
    );
  }
}
