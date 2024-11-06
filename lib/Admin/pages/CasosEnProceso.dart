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
  bool showFilters = true;

  List<String> subcategoriasDisponibles = [];
  List<String> subsubcategoriasDisponibles = [];

  @override
  void initState() {
    super.initState();
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
      subcategoriasDisponibles = [];
      subsubcategoriasDisponibles = [];
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Título y botón de expandir/colapsar filtros
            Container(
              color: Colors.pinkAccent.withOpacity(0.1),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Filtrar por tipo de caso",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      showFilters ? Icons.expand_less : Icons.expand_more,
                      color: Colors.blueGrey[800],
                    ),
                    onPressed: () {
                      setState(() {
                        showFilters = !showFilters;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Panel de filtros con Dropdowns adaptativos
            if (showFilters)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.blueGrey[100]!),
                  ),
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Categoría',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        isExpanded: true,
                        value: categoriaSeleccionada,
                        items: Categorias.categorias.keys
                            .map((String categoria) => DropdownMenuItem<String>(
                                  value: categoria,
                                  child: Text(
                                    categoria,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            categoriaSeleccionada = value;
                            subcategoriasDisponibles = value != null
                                ? Categorias.categorias[value]!.keys.toList()
                                : [];
                            subcategoriaSeleccionada = null;
                            subsubcategoriaSeleccionada = null;
                            subsubcategoriasDisponibles = [];
                          });
                          aplicarFiltros();
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Subcategoría',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        isExpanded: true,
                        value: subcategoriaSeleccionada,
                        items: subcategoriasDisponibles
                            .map((String subcategoria) =>
                                DropdownMenuItem<String>(
                                  value: subcategoria,
                                  child: Text(
                                    subcategoria,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            subcategoriaSeleccionada = value;
                            subsubcategoriasDisponibles = value != null
                                ? Categorias
                                    .categorias[categoriaSeleccionada]![value]!
                                : [];
                            subsubcategoriaSeleccionada = null;
                          });
                          aplicarFiltros();
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Sub-Subcategoría',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        isExpanded: true,
                        value: subsubcategoriaSeleccionada,
                        items: subsubcategoriasDisponibles
                            .map((String subsubcategoria) =>
                                DropdownMenuItem<String>(
                                  value: subsubcategoria,
                                  child: Text(
                                    subsubcategoria,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            subsubcategoriaSeleccionada = value;
                          });
                          aplicarFiltros();
                        },
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Lista de reportes
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Reportes(
                  estado: 'En Proceso',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
