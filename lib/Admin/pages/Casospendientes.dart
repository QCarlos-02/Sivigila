import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/Widgets/listaReportes.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';
import 'package:sivigila/Admin/Widgets/categorias.dart';

class Casospendientes extends StatefulWidget {
  const Casospendientes({super.key});

  @override
  State<Casospendientes> createState() => _CasospendientesState();
}

class _CasospendientesState extends State<Casospendientes> {
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
    reporteController.consultarReportesPorEstado("Pendiente");
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
        title: const Text("Casos Pendientes"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_off, color: Colors.white),
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
              color: Colors.lightBlue.withOpacity(0.2),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.filter_list, color: Colors.blueGrey[800]),
                      const SizedBox(width: 8),
                      Text(
                        "Filtrar por tipo de caso",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800],
                        ),
                      ),
                    ],
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Categoría',
                          prefixIcon: Icon(Icons.category, color: Colors.blueAccent),
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
                                    style: const TextStyle(fontSize: 14),
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
                          prefixIcon: Icon(Icons.subdirectory_arrow_right, color: Colors.blueAccent),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        isExpanded: true,
                        value: subcategoriaSeleccionada,
                        items: subcategoriasDisponibles
                            .map((String subcategoria) => DropdownMenuItem<String>(
                                  value: subcategoria,
                                  child: Text(
                                    subcategoria,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            subcategoriaSeleccionada = value;
                            subsubcategoriasDisponibles = value != null
                                ? Categorias.categorias[categoriaSeleccionada]![value]!
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
                          prefixIcon: Icon(Icons.subdirectory_arrow_right_outlined, color: Colors.blueAccent),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        isExpanded: true,
                        value: subsubcategoriaSeleccionada,
                        items: subsubcategoriasDisponibles
                            .map((String subsubcategoria) => DropdownMenuItem<String>(
                                  value: subsubcategoria,
                                  child: Text(
                                    subsubcategoria,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14),
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
                  estado: 'Pendiente',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
