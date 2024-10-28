import 'package:flutter/material.dart';
import 'package:sivigila/Pagina/formulario_reporte.dart';

class FactoresPotencialmenteRelacionados extends StatelessWidget {
  const FactoresPotencialmenteRelacionados({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        'Factores Potencialmente Relacionados',
        style: TextStyle(fontSize: 18),
      ),
      children: [
        _buildListTile(
          context,
          icon: Icons.water_drop,
          title: 'Fuentes Hídricas',
          dialogTitle: 'Contaminación de Fuentes Hídricas',
          items: [
            _buildDialogItem(
              context,
              'Contaminación de origen natural',
              Icons.nature,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fuentes Hídricas',
              subcategoria: 'Contaminación',
              subsubcategoria: 'Contaminación de origen natural',
            ),
            _buildDialogItem(
              context,
              'Contaminación de origen humano',
              Icons.people,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fuentes Hídricas',
              subcategoria: 'Contaminación',
              subsubcategoria: 'Contaminación de origen humano',
            ),
            _buildDialogItem(
              context,
              'Escasez de Agua Potable',
              Icons.water,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fuentes Hídricas',
              subcategoria: 'Disponibilidad',
              subsubcategoria: 'Escasez de Agua Potable',
            ),
          ],
        ),
        _buildListTile(
          context,
          icon: Icons.terrain,
          title: 'Fenómenos Naturales',
          dialogTitle: 'Fenómenos Naturales',
          items: [
            _buildDialogItem(
              context,
              'Huracanes',
              Icons.cloud_outlined,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fenómenos Naturales',
              subcategoria: 'Desastres Naturales',
              subsubcategoria: 'Huracanes',
            ),
            _buildDialogItem(
              context,
              'Inundaciones',
              Icons.flood,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fenómenos Naturales',
              subcategoria: 'Desastres Naturales',
              subsubcategoria: 'Inundaciones',
            ),
          ],
        ),
        _buildListTile(
          context,
          icon: Icons.people,
          title: 'Sociales',
          dialogTitle: 'Factores Sociales',
          items: [
            _buildDialogItem(
              context,
              'Desigualdad Social',
              Icons.equalizer,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Sociales',
              subcategoria: 'Problemas Sociales',
              subsubcategoria: 'Desigualdad Social',
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(dialogTitle),
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
      },
    );
  }

  Container _buildDialogItem(
    BuildContext context,
    String title,
    IconData icon, {
    required String seccion,
    required String categoria,
    required String subcategoria,
    required String subsubcategoria,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () {
          Navigator.of(context).pop(); // Cierra el diálogo
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
          evento: subsubcategoria,
        ),
      ),
    );
  }
}
