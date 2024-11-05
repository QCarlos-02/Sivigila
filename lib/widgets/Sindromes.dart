import 'package:flutter/material.dart';
import 'package:sivigila/Pagina/formulario_reporte.dart';

class Sindromes extends StatelessWidget {
  const Sindromes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          tileIcon: Icons.thermostat,
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
          tileIcon: Icons.health_and_safety,
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
          tileIcon: Icons.local_hospital,
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
          tileIcon: Icons.air,
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
    required IconData tileIcon,
  }) {
    return ListTile(
      leading: Icon(tileIcon, color: Colors.blueAccent),
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
                  children: options
                      .map((option) => buildDialogItem(
                            context,
                            option['title'],
                            seccion: seccion,
                            categoria: categoria,
                            subcategoria: title,
                            subsubcategoria: option['title'],
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
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget buildDialogItem(
    BuildContext context,
    String title, {
    required String seccion,
    required String categoria,
    required String subcategoria,
    required String subsubcategoria,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
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
