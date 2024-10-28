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
<<<<<<< HEAD
                          evento: 'Muertes perinatales',
                          itemIcon: Icons.pregnant_woman, // Ícono actualizado
=======
                          subcategoria: 'Etapas de Vida',
                          subsubcategoria:
                              'Antes de nacer y hasta el primer mes de vida',
                          itemIcon: Icons.pregnant_woman,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
                        ),
                        _buildDialogItem(
                          context,
                          'Muertes infantiles (niños y niñas menores de 5 años)',
                          seccion: 'Muertes en Comunidad',
                          categoria: 'Muertes Infantiles',
<<<<<<< HEAD
                          evento: 'Muertes infantiles',
                          itemIcon: Icons.child_care, // Ícono para el ítem
=======
                          subcategoria: 'Infantil',
                          subsubcategoria: 'Niños y niñas menores de 5 años',
                          itemIcon: Icons.child_care,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
                        ),
                        _buildDialogItem(
                          context,
                          'Muertes maternas (embarazadas, en postparto y hasta un año de haber terminado el embarazo)',
                          seccion: 'Muertes en Comunidad',
                          categoria: 'Muertes Maternas',
<<<<<<< HEAD
                          evento: 'Muertes maternas',
                          itemIcon: Icons.woman, // Ícono para el ítem
=======
                          subcategoria: 'Maternas',
                          subsubcategoria:
                              'Embarazadas, postparto y hasta un año',
                          itemIcon: Icons.woman,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
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
<<<<<<< HEAD
    required String evento,
    required IconData itemIcon, // Ícono para el ítem
=======
    required String subcategoria,
    required String subsubcategoria,
    required IconData itemIcon,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
<<<<<<< HEAD
        leading: Icon(itemIcon), // Ícono en el ListTile
        title: Text(title),
        onTap: () {
          Navigator.of(context).pop(); // Cierra el diálogo
=======
        leading: Icon(itemIcon),
        title: Text(title),
        onTap: () {
          Navigator.of(context).pop();
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
          _navegarFormulario(
            context,
            seccion: seccion,
            categoria: categoria,
<<<<<<< HEAD
            evento: evento,
=======
            subcategoria: subcategoria,
            subsubcategoria: subsubcategoria,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
          );
        },
      ),
    );
  }

  // Método para navegar al formulario y pasar los datos
<<<<<<< HEAD
  void _navegarFormulario(BuildContext context,
      {required String seccion,
      required String categoria,
      required String evento}) {
=======
  void _navegarFormulario(
    BuildContext context, {
    required String seccion,
    required String categoria,
    required String subcategoria,
    required String subsubcategoria,
  }) {
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioReporte(
          seccion: seccion,
          categoria: categoria,
<<<<<<< HEAD
          evento: evento,
=======
          subcategoria: subcategoria,
          subsubcategoria: subsubcategoria,
          evento: subsubcategoria,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
        ),
      ),
    );
  }
}
