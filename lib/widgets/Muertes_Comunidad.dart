import 'package:flutter/material.dart';
import 'package:sivigila/Pagina/formulario_reporte.dart';

class MuertesComunidad extends StatelessWidget {
  const MuertesComunidad({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Muertes en Comunidad'),
      children: [
        ListTile(
          leading: const Icon(Icons.local_hospital),
          title: const Text('Muertes Perinatales'),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Tipos de Muertes Perinatales'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildDialogItem(
                          context,
                          'Muertes perinatales (antes de nacer y hasta el primer mes de vida)',
                          seccion: 'Muertes en Comunidad',
                          categoria: 'Muertes Perinatales',
                          subcategoria: 'Etapas de Vida',
                          subsubcategoria:
                              'Antes de nacer y hasta el primer mes de vida',
                          itemIcon: Icons.pregnant_woman,
                        ),
                        _buildDialogItem(
                          context,
                          'Muertes infantiles (niños y niñas menores de 5 años)',
                          seccion: 'Muertes en Comunidad',
                          categoria: 'Muertes Infantiles',
                          subcategoria: 'Infantil',
                          subsubcategoria: 'Niños y niñas menores de 5 años',
                          itemIcon: Icons.child_care,
                        ),
                        _buildDialogItem(
                          context,
                          'Muertes maternas (embarazadas, en postparto y hasta un año de haber terminado el embarazo)',
                          seccion: 'Muertes en Comunidad',
                          categoria: 'Muertes Maternas',
                          subcategoria: 'Maternas',
                          subsubcategoria:
                              'Embarazadas, postparto y hasta un año',
                          itemIcon: Icons.woman,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  Container _buildDialogItem(
    BuildContext context,
    String title, {
    required String seccion,
    required String categoria,
    required String subcategoria,
    required String subsubcategoria,
    required IconData itemIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(itemIcon),
        title: Text(title),
        onTap: () {
          Navigator.of(context).pop();
          _navegarFormulario(
            context,
            seccion: seccion,
            categoria: categoria,
            subcategoria: subcategoria,
            subsubcategoria: subsubcategoria,
          );
        },
      ),
    );
  }

  // Método para navegar al formulario y pasar los datos
  void _navegarFormulario(
    BuildContext context, {
    required String seccion,
    required String categoria,
    required String subcategoria,
    required String subsubcategoria,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioReporte(
          seccion: seccion,
          categoria: categoria,
          subcategoria: subcategoria,
          subsubcategoria: subsubcategoria,
        ),
      ),
    );
  }
}
