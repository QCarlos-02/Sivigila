import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/Widgets/categorias.dart';
import 'package:sivigila/Admin/Widgets/listaReportes.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';

class Casosenproceso extends StatefulWidget {
  const Casosenproceso({super.key});

  @override
  State<Casosenproceso> createState() => _CasosenprocesoState();
}

class _CasosenprocesoState extends State<Casosenproceso> {
  final Reportecontroller reporteController = Get.find();

  String? categoriaSeleccionada;
  String? subcategoriaSeleccionada;
  String? subsubcategoriaSeleccionada;

  @override
  void initState() {
    super.initState();
    reporteController.consultarReportesPorEstado("En Proceso");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    reporteController.consultarReportesPorEstado("En Proceso");
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
        title: const Text("Casos En Proceso"),
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
            child: Reportes(
              estado: 'En Proceso',
            ), // Mostrar lista de reportes filtrados
          ),
        ],
      ),
    );
  }
}
