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
<<<<<<< HEAD
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
=======
  final Reportecontroller reporteController = Get.find();

  String? categoriaSeleccionada;
  String? subcategoriaSeleccionada;
  String? subsubcategoriaSeleccionada;

  @override
  void initState() {
    super.initState();
    reporteController.consultarReportesgeneral();
  }

  void aplicarFiltros() {
    reporteController.filtrarReportes(
      categoria: categoriaSeleccionada,
      subcategoria: subcategoriaSeleccionada,
      subsubcategoria: subsubcategoriaSeleccionada,
    );
  }

  void limpiarFiltros() {
    setState(() {
      categoriaSeleccionada = null;
      subcategoriaSeleccionada = null;
      subsubcategoriaSeleccionada = null;
    });
    reporteController.limpiarFiltros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Casos pendientes"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_off),
            onPressed: limpiarFiltros,
            tooltip: 'Limpiar filtros',
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Filtrar por tipo de caso",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          CategoriaSubcategoriaWidget(
            onSelectionChanged: (String? categoria, String? subcategoria,
                String? subsubcategoria) {
              setState(() {
                categoriaSeleccionada = categoria;
                subcategoriaSeleccionada = subcategoria;
                subsubcategoriaSeleccionada = subsubcategoria;
              });
              aplicarFiltros();
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Reportes(), // Mostrar lista de reportes filtrados
          ),
        ],
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
      ),
    );
  }
}
