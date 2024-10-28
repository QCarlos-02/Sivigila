import 'package:flutter/material.dart';
import 'package:sivigila/Pagina/formulario_reporte.dart';

class Conglomerados extends StatelessWidget {
  const Conglomerados({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Conglomerados'),
      children: [
        _buildListTile(
          context,
          icon: Icons.location_city,
          title: 'Tipos De Conglomerados',
          dialogTitle: 'Tipos De Conglomerados',
          items: [
            _buildDialogItem(
              context,
              'Conglomerado en centro penitenciario',
              seccion: 'Conglomerados',
              categoria: 'Centro Penitenciario',
<<<<<<< HEAD
              evento: 'Conglomerado en centro penitenciario',
              itemIcon: Icons.lock, // Icono para el ítem
=======
              subcategoria: 'Tipo de Conglomerado',
              subsubcategoria: 'Conglomerado en centro penitenciario',
              itemIcon: Icons.lock,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
            ),
            _buildDialogItem(
              context,
              'Conglomerado en institución educativa',
              seccion: 'Conglomerados',
              categoria: 'Institución Educativa',
<<<<<<< HEAD
              evento: 'Conglomerado en institución educativa',
              itemIcon: Icons.school, // Icono para el ítem
=======
              subcategoria: 'Tipo de Conglomerado',
              subsubcategoria: 'Conglomerado en institución educativa',
              itemIcon: Icons.school,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
            ),
            _buildDialogItem(
              context,
              'Conglomerado en hogar de bienestar infantil',
              seccion: 'Conglomerados',
              categoria: 'Hogar de Bienestar Infantil',
<<<<<<< HEAD
              evento: 'Conglomerado en hogar de bienestar infantil',
              itemIcon: Icons.child_care, // Icono para el ítem
=======
              subcategoria: 'Tipo de Conglomerado',
              subsubcategoria: 'Conglomerado en hogar de bienestar infantil',
              itemIcon: Icons.child_care,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
            ),
          ],
        ),
      ],
    );
  }

  ListTile _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String dialogTitle,
    required List<Widget> items,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        _showDialog(context, dialogTitle, items);
      },
    );
  }

  void _showDialog(BuildContext context, String title, List<Widget> items) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
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
  }

  Container _buildDialogItem(
    BuildContext context,
    String title, {
    required String seccion,
    required String categoria,
<<<<<<< HEAD
    required String evento,
    required IconData itemIcon, // Icono para el ítem
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
        leading: Icon(itemIcon), // Icono en el ListTile
=======
        leading: Icon(itemIcon),
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
        title: Text(title),
        onTap: () {
          Navigator.of(context).pop();
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

  void _navegarFormulario(
    BuildContext context, {
    required String seccion,
    required String categoria,
<<<<<<< HEAD
    required String evento,
=======
    required String subcategoria,
    required String subsubcategoria,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
  }) {
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
