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
                          evento: 'Muertes perinatales',
                          itemIcon: Icons.pregnant_woman, // Ícono actualizado
                        ),
                        _buildDialogItem(
                          context,
                          'Muertes infantiles (niños y niñas menores de 5 años)',
                          seccion: 'Muertes en Comunidad',
                          categoria: 'Muertes Infantiles',
                          evento: 'Muertes infantiles',
                          itemIcon: Icons.child_care, // Ícono para el ítem
                        ),
                        _buildDialogItem(
                          context,
                          'Muertes maternas (embarazadas, en postparto y hasta un año de haber terminado el embarazo)',
                          seccion: 'Muertes en Comunidad',
                          categoria: 'Muertes Maternas',
                          evento: 'Muertes maternas',
                          itemIcon: Icons.woman, // Ícono para el ítem
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
    required String evento,
    required IconData itemIcon, // Ícono para el ítem
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(itemIcon), // Ícono en el ListTile
        title: Text(title),
        onTap: () {
          Navigator.of(context).pop(); // Cierra el diálogo
          _navegarFormulario(
            context,
            seccion: seccion,
            categoria: categoria,
            evento: evento,
          );
        },
      ),
    );
  }

  // Método para navegar al formulario y pasar los datos
  void _navegarFormulario(BuildContext context,
      {required String seccion,
      required String categoria,
      required String evento}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioReporte(
          seccion: seccion,
          categoria: categoria,
          evento: evento,
        ),
      ),
    );
  }
}
