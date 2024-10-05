import 'package:flutter/material.dart';
import 'package:sivigila/Pagina/formulario_reporte.dart';

class CasosEspecificos extends StatelessWidget {
  const CasosEspecificos({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Casos Específicos'),
      children: [
        _buildListTile(
          context,
          icon: Icons.health_and_safety,
          title: 'Enfermedades de Transmisión Sexual (ETS):',
          dialogTitle: 'Tipos De Enfermedades de Transmisión Sexual (ETS)',
          items: [
            _buildDialogItem(
              context,
              'VIH (Virus de Inmunodeficiencia Humana)',
              Icons.health_and_safety,
              seccion: 'Casos Específicos',
              categoria: 'Enfermedades de Transmisión Sexual',
              evento: 'VIH',
            ),
            _buildDialogItem(
              context,
              'Sífilis',
              Icons.health_and_safety,
              seccion: 'Casos Específicos',
              categoria: 'Enfermedades de Transmisión Sexual',
              evento: 'Sífilis',
            ),
          ],
        ),
        _buildListTile(
          context,
          icon: Icons.sick,
          title: 'Enfermedades Infecciosas Respiratorias',
          dialogTitle: 'Tipos De Enfermedades Infecciosas Respiratorias',
          items: [
            _buildDialogItem(
              context,
              'Covid-19',
              Icons.sick,
              seccion: 'Casos Específicos',
              categoria: 'Enfermedades Infecciosas Respiratorias',
              evento: 'Covid-19',
            ),
          ],
        ),
        _buildListTile(
          context,
          icon: Icons.bug_report,
          title: 'Enfermedades Transmitidas por Vectores',
          dialogTitle: 'Tipos De Enfermedades Por Vectores',
          items: [
            _buildDialogItem(
              context,
              'Malaria',
              Icons.bug_report,
              seccion: 'Casos Específicos',
              categoria: 'Enfermedades Transmitidas por Vectores',
              evento: 'Malaria',
            ),
            _buildDialogItem(
              context,
              'Leishmaniasis',
              Icons.bug_report,
              seccion: 'Casos Específicos',
              categoria: 'Enfermedades Transmitidas por Vectores',
              evento: 'Leishmaniasis',
            ),
            _buildDialogItem(
              context,
              'Dengue',
              Icons.bug_report,
              seccion: 'Casos Específicos',
              categoria: 'Enfermedades Transmitidas por Vectores',
              evento: 'Dengue',
            ),
            _buildDialogItem(
              context,
              'Chagas',
              Icons.bug_report,
              seccion: 'Casos Específicos',
              categoria: 'Enfermedades Transmitidas por Vectores',
              evento: 'Chagas',
            ),
          ],
        ),
        _buildListTile(
          context,
          icon: Icons.fastfood,
          title: 'Condiciones Relacionadas con la Nutrición',
          dialogTitle: 'Tipos De Condiciones',
          items: [
            _buildDialogItem(
              context,
              'Desnutrición',
              Icons.fastfood,
              seccion: 'Casos Específicos',
              categoria: 'Condiciones Nutricionales',
              evento: 'Desnutrición',
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
          Navigator.of(context).pop();
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
