import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/Widgets/categorias.dart';
import 'package:sivigila/Admin/Widgets/listaReportes.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';

class Casosexitosos extends StatefulWidget {
  const Casosexitosos({super.key});

  @override
  State<Casosexitosos> createState() => _CasosexitososState();
}

class _CasosexitososState extends State<Casosexitosos> {
  final Reportecontroller reporteController = Get.find();

  String? categoriaSeleccionada;
  String? subcategoriaSeleccionada;
  String? subsubcategoriaSeleccionada;

  @override
  void initState() {
    super.initState();
    reporteController.consultarReportesPorEstado("Exitoso");
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
          title: const Text(
            "Casos exitosos",
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: limpiarFiltros,
              icon: const Icon(Icons.filter_alt_off),
              tooltip: 'Limpiar filtros',
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado de filtro
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Filtrar por tipo de caso",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
            ),

            // Contenedor de Filtros
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.blueGrey[100]!),
                ),
                child: CategoriaSubcategoriaWidget(
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
              ),
            ),

            // Espacio entre los filtros y la lista de reportes
            const SizedBox(height: 20),

            // Lista de reportes filtrados
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Reportes(
                  estado: 'Exitoso',
                ),
              ),
            ),
          ],
        ));
  }
}
