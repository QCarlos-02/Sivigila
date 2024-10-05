import 'package:flutter/material.dart';

class Categorias {
  static const Map<String, List<String>> categorias = {
    'Violencia': ['Violencia familiar', 'Violencia escolar'],
    'Fuentes Hidricas': ['Falta de agua'],
    'Fenomenos Naturales': ['Incendios forestales'],
    'Sociales': ['Ejemplo']
  };
}

class CategoriaSubcategoriaWidget extends StatefulWidget {
  final Map<String, List<String>> categorias;
  final Function(String?, String?) onSelectionChanged;

  const CategoriaSubcategoriaWidget({
    super.key,
    this.categorias = Categorias.categorias,
    required this.onSelectionChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CategoriaSubcategoriaWidgetState createState() =>
      _CategoriaSubcategoriaWidgetState();
}

class _CategoriaSubcategoriaWidgetState
    extends State<CategoriaSubcategoriaWidget> {
  String? categoriaSeleccionada;
  String? subcategoriaSeleccionada;
  List<String> subcategoriasDisponibles = [];

  @override
  void initState() {
    super.initState();
    subcategoriasDisponibles = [];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // DropdownButton para seleccionar la categoría con tamaño controlado
              SizedBox(
                // Ancho controlado del Dropdown
                child: DropdownButton<String>(
                  value: categoriaSeleccionada,
                  hint: const Text('Categoría'),
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text("Categoría"),
                    ),
                    ...widget.categorias.keys.map((String categoria) {
                      return DropdownMenuItem<String>(
                        value: categoria,
                        child: Text(categoria),
                      );
                    }),
                  ],
                  onChanged: (String? nuevaCategoria) {
                    setState(() {
                      categoriaSeleccionada = nuevaCategoria;
                      if (nuevaCategoria != null) {
                        subcategoriasDisponibles =
                            widget.categorias[nuevaCategoria]!;
                        subcategoriaSeleccionada = null;
                      } else {
                        subcategoriasDisponibles = [];
                        subcategoriaSeleccionada = null;
                      }
                    });
                    widget.onSelectionChanged(
                        categoriaSeleccionada, subcategoriaSeleccionada);
                  },
                ),
              ),
              const SizedBox(width: 30), // Espacio entre los Dropdowns
              // DropdownButton para seleccionar la subcategoría con tamaño controlado
              SizedBox(
                // Ancho controlado del Dropdown
                child: DropdownButton<String>(
                  value: subcategoriaSeleccionada,
                  hint: const Text('Subcategoría'),
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text("Subcategoría"),
                    ),
                    ...subcategoriasDisponibles.map((String subcategoria) {
                      return DropdownMenuItem<String>(
                        value: subcategoria,
                        child: Text(subcategoria),
                      );
                    }),
                  ],
                  onChanged: (String? nuevaSubcategoria) {
                    setState(() {
                      subcategoriaSeleccionada = nuevaSubcategoria;
                    });
                    widget.onSelectionChanged(
                        categoriaSeleccionada, subcategoriaSeleccionada);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
