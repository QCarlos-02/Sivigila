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
              evento: 'Contaminación de origen natural',
            ),
            _buildDialogItem(
              context,
              'Contaminación de origen humano',
              Icons.people,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fuentes Hídricas',
              evento: 'Contaminación de origen humano',
            ),
            _buildDialogItem(
              context,
              'Escasez de Agua Potable',
              Icons.water,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fuentes Hídricas',
              evento: 'Escasez de Agua Potable',
            ),
            _buildDialogItem(
              context,
              'Ausencia de alcantarillado',
              Icons.plumbing,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fuentes Hídricas',
              evento: 'Ausencia de alcantarillado',
            ),
            _buildDialogItem(
              context,
              'Atmósfera',
              Icons.cloud,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fuentes Hídricas',
              evento: 'Atmósfera',
            ),
            _buildDialogItem(
              context,
              'Incendios',
              Icons.fireplace,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fuentes Hídricas',
              evento: 'Incendios',
            ),
            _buildDialogItem(
              context,
              'Quema De Basura',
              Icons.delete,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fuentes Hídricas',
              evento: 'Quema De Basura',
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
              evento: 'Huracanes',
            ),
            _buildDialogItem(
              context,
              'Inundaciones, Desbordamientos o Avenidas Torreciales',
              Icons.flood,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fenómenos Naturales',
              evento: 'Inundaciones',
            ),
            _buildDialogItem(
              context,
              'Erupciones Volcánicas',
              Icons.landscape,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fenómenos Naturales',
              evento: 'Erupciones Volcánicas',
            ),
            _buildDialogItem(
              context,
              'Sismos O Terremotos',
              Icons.vibration,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fenómenos Naturales',
              evento: 'Sismos O Terremotos',
            ),
            _buildDialogItem(
              context,
              'Presencia De Plagas',
              Icons.bug_report,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fenómenos Naturales',
              evento: 'Presencia De Plagas',
            ),
            _buildDialogItem(
              context,
              'Sequias',
              Icons.wb_sunny,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fenómenos Naturales',
              evento: 'Sequias',
            ),
            _buildDialogItem(
              context,
              'Tsunamis',
              Icons.waves,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Fenómenos Naturales',
              evento: 'Tsunamis',
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
              evento: 'Desigualdad Social',
            ),
            _buildDialogItem(
              context,
              'Falta de Servicios Básicos',
              Icons.no_meals,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Sociales',
              evento: 'Falta de Servicios Básicos',
            ),
            _buildDialogItem(
              context,
              'Conflictos Sociales',
              Icons.warning,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Sociales',
              evento: 'Conflictos Sociales',
            ),
            _buildDialogItem(
              context,
              'Migración Masiva',
              Icons.airplanemode_active,
              seccion: 'Factores Potencialmente Relacionados',
              categoria: 'Sociales',
              evento: 'Migración Masiva',
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
    required String evento,
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
            evento: evento,
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
    required String evento,
  }) {
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
