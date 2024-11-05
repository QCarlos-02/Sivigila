import 'package:flutter/material.dart';
import 'package:sivigila/Pagina/formulario_reporte.dart';

class MuertesComunidad extends StatelessWidget {
  const MuertesComunidad({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildListTile(
          context,
          icon: Icons.local_hospital,
          title: 'Muertes Perinatales',
          dialogTitle: 'Tipos de Muertes Perinatales',
          items: [
            _buildDialogItem(
              context,
              'Muertes perinatales (antes de nacer y hasta el primer mes de vida)',
              seccion: 'Muertes en Comunidad',
              categoria: 'Muertes Perinatales',
              subcategoria: 'Etapas de Vida',
              subsubcategoria: 'Antes de nacer y hasta el primer mes de vida',
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
              subsubcategoria: 'Embarazadas, postparto y hasta un año',
              itemIcon: Icons.woman,
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
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                dialogTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
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
                  child: const Text('Cancelar', style: TextStyle(color: Colors.redAccent)),
                ),
              ],
            );
          },
        );
      },
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
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(itemIcon, color: Colors.blueAccent),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
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
