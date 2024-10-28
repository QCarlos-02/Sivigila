import 'package:flutter/material.dart';

class Categorias {
  static const Map<String, Map<String, List<String>>> categorias = {
    'Factores potencialmente relacionados': {
      'Fuentes hídricas': [
        'Contaminación de origen natural',
        'Contaminación de origen humano',
        'Escasez de agua potable',
        'Ausencia de alcantarillado',
        'Atmósfera',
        'Incendios',
        'Quema de basura'
      ],
      'Fenómenos naturales': [
        'Huracanes',
        'Inundaciones',
        'Desbordamiento o avenidas torrenciales',
        'Erupciones volcánicas',
        'Sismos o terremotos',
        'Presencia de plagas',
        'Sequías',
        'Tsunamis'
      ],
      'Sociales': [
        'Desigualdad social',
        'Falta de servicios básicos',
        'Conflictos sociales',
        'Migración masiva'
      ],
    },
    'Situación en animales': {
      'Mordidas y arañazos': [
        'Mordedura por perro',
        'Mordedura por zorro o zarigüeya',
        'Mordedura de serpiente',
        'Mordedura de arañas'
      ],
      'Envenenamiento o picadura': [
        'Picadura de Alacranes o Escorpiones',
        'Contacto con animales ponzoñosos'
      ],
      'Muerte extraña': [
        'Contacto con un animal que posteriormente falleció sin razón aparente'
      ],
    },
    'Síndromes': {
      'Síndrome febril': [
        'Síndrome febril normal',
        'Síndrome febril ictérico',
        'Síndrome febril exantemático'
      ],
      'Síndrome neurológico': [
        'Fiebre, rigidez en la cabeza y cuello, dificultad para caminar, parálisis, convulsiones'
      ],
      'Síndrome diarreico': [
        'Fiebre + diarrea y ganas de vomitar o vómito persistente'
      ],
      'Síndrome respiratorio': ['Tos mayor a 15 días'],
    },
    'Casos específicos': {
      'Enfermedades de transmisión sexual (ETS)': [
        'VIH (Virus de inmunodeficiencia humana)'
      ],
      'Enfermedades de transmisión sexual': ['Sífilis'],
      'Enfermedades infecciosas respiratorias': ['Covid-19'],
      'Enfermedades transmitidas por vectores': [
        'Malaria',
        'Leishmaniasis',
        'Dengue',
        'Chagas'
      ],
      'Condiciones relacionadas con la nutrición': ['Desnutrición'],
    },
    'Muertes en comunidad': {
      'Muertes perinatales': [
        'Antes de nacer y hasta el primer mes de vida',
        'Muertes infantiles (niños y niñas menores de 5 años)',
        'Muerte materna (embarazadas, en postparto y hasta un año de haber terminado el embarazo)'
      ],
    },
    'Conglomerados': {
      'Tipos de conglomerados': [
        'Conglomerado en centro penitenciario',
        'Conglomerado en institución educativa',
        'Conglomerado en hogar de bienestar infantil',
      ]
    }
  };
}

class CategoriaSubcategoriaWidget extends StatefulWidget {
  final Function(String?, String?, String?) onSelectionChanged;

  const CategoriaSubcategoriaWidget({
    super.key,
    required this.onSelectionChanged,
  });

  @override
  _CategoriaSubcategoriaWidgetState createState() =>
      _CategoriaSubcategoriaWidgetState();
}

class _CategoriaSubcategoriaWidgetState
    extends State<CategoriaSubcategoriaWidget> {
  String? categoriaSeleccionada;
  String? subcategoriaSeleccionada;
  String? subsubcategoriaSeleccionada;

  List<String> subcategoriasDisponibles = [];
  List<String> subsubcategoriasDisponibles = [];

  @override
  void initState() {
    super.initState();
    // Puedes seleccionar una categoría predeterminada aquí si lo deseas
  }

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 600;

    return Center(
      child: isWideScreen
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildDropdowns(),
            )
          : Column(
              children: _buildDropdowns(),
            ),
    );
  }

  List<Widget> _buildDropdowns() {
    return [
      // Selección de categoría principal
      Expanded(
        child: DropdownButton<String>(
          value: categoriaSeleccionada,
          hint: const Text('Categoría'),
          isExpanded: true,
          items: Categorias.categorias.keys.map((String categoria) {
            return DropdownMenuItem<String>(
              value: categoria,
              child: Text(categoria),
            );
          }).toList(),
          onChanged: (String? nuevaCategoria) {
            setState(() {
              categoriaSeleccionada = nuevaCategoria;
              subcategoriasDisponibles =
                  Categorias.categorias[nuevaCategoria]!.keys.toList();
              subcategoriaSeleccionada = null;
              subsubcategoriasDisponibles = [];
              subsubcategoriaSeleccionada = null;
            });
            widget.onSelectionChanged(categoriaSeleccionada,
                subcategoriaSeleccionada, subsubcategoriaSeleccionada);
          },
        ),
      ),
      const SizedBox(width: 10, height: 10),

      // Selección de subcategoría
      Expanded(
        child: DropdownButton<String>(
          value: subcategoriaSeleccionada,
          hint: const Text('Subcategoría'),
          isExpanded: true,
          items: [
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
              subsubcategoriasDisponibles = Categorias
                  .categorias[categoriaSeleccionada]![nuevaSubcategoria]!;
              subsubcategoriaSeleccionada = null;
            });
            widget.onSelectionChanged(categoriaSeleccionada,
                subcategoriaSeleccionada, subsubcategoriaSeleccionada);
          },
        ),
      ),
      const SizedBox(width: 10, height: 10),

      // Selección de sub-subcategoría
      Expanded(
        child: DropdownButton<String>(
          value: subsubcategoriaSeleccionada,
          hint: const Text('Sub-subcategoría'),
          isExpanded: true,
          items: [
            ...subsubcategoriasDisponibles.map((String subsubcategoria) {
              return DropdownMenuItem<String>(
                value: subsubcategoria,
                child: Text(subsubcategoria),
              );
            }),
          ],
          onChanged: (String? nuevaSubsubcategoria) {
            setState(() {
              subsubcategoriaSeleccionada = nuevaSubsubcategoria;
            });
            widget.onSelectionChanged(categoriaSeleccionada,
                subcategoriaSeleccionada, subsubcategoriaSeleccionada);
          },
        ),
      ),
    ];
  }
}
