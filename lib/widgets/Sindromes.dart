import 'package:flutter/material.dart';
import 'package:sivigila/Pagina/formulario_reporte.dart';

class Sindromes extends StatelessWidget {
  const Sindromes({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Síndromes'),
      children: [
        _buildSyndromeTile(
          context,
          title: 'Síndrome Febril',
          dialogTitle: 'Tipos De Síndromes Febriles',
          seccion: 'Síndromes',
          categoria: 'Síndrome Febril',
          options: [
            {'title': 'Síndrome Febril Normal', 'icon': Icons.thermostat},
            {'title': 'Síndrome Febril Ictérico', 'icon': Icons.thermostat},
            {'title': 'Síndrome Febril Exantemático', 'icon': Icons.thermostat},
          ],
          tileIcon: Icons.thermostat, // Icono para el título
        ),
        _buildSyndromeTile(
          context,
          title: 'Síndrome Neurológico',
          dialogTitle: 'Tipos De Síndromes Neurológicos',
          seccion: 'Síndromes',
          categoria: 'Síndrome Neurológico',
          options: [
            {
              'title':
                  'Síndrome Neurológico (Fiebre + Rigidez En La Cabeza y Cuello, Dificultad Para Caminar + Parálisis + Convulsiones)',
              'icon': Icons.health_and_safety
            },
          ],
          tileIcon: Icons.health_and_safety, // Icono para el título
        ),
        _buildSyndromeTile(
          context,
          title: 'Síndrome Diarreico',
          dialogTitle: 'Tipos De Síndromes Diarreicos',
          seccion: 'Síndromes',
          categoria: 'Síndrome Diarreico',
          options: [
            {
              'title':
                  'Síndrome Diarreico (Fiebre + Diarrea y Ganas De Vomitar o Vómito Persistente)',
              'icon': Icons.local_hospital
            },
          ],
          tileIcon: Icons.local_hospital, // Icono para el título
        ),
        _buildSyndromeTile(
          context,
          title: 'Síndrome Respiratorio',
          dialogTitle: 'Tipos De Síndromes Respiratorios',
          seccion: 'Síndromes',
          categoria: 'Síndrome Respiratorio',
          options: [
            {
              'title': 'Síndrome Respiratorio (Tos Mayor a 15 Días)',
              'icon': Icons.air
            },
          ],
          tileIcon: Icons.air, // Icono para el título
        ),
      ],
    );
  }

  ListTile _buildSyndromeTile(
    BuildContext context, {
    required String title,
    required String dialogTitle,
    required String seccion,
    required String categoria,
    required List<Map<String, dynamic>> options,
    required IconData tileIcon, // Icono para el título
  }) {
    return ListTile(
      title: Row(
        children: [
          Icon(tileIcon), // Icono en el título
          const SizedBox(width: 8), // Espacio entre el icono y el texto
          Text(title),
        ],
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(dialogTitle),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: options
                      .map((option) => buildDialogItem(
                            context,
                            option['title'],
                            seccion: seccion,
                            categoria: categoria,
                            evento: option['title'],
                            icon: option['icon'],
                          ))
                      .toList(),
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

  // Método para construir cada `ListTile` dentro del `AlertDialog`
  Widget buildDialogItem(
    BuildContext context,
    String title, {
    required String seccion,
    required String categoria,
    required String evento,
    required IconData icon,
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
