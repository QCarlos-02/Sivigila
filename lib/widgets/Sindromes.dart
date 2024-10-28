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
<<<<<<< HEAD
          tileIcon: Icons.thermostat, // Icono para el título
=======
          tileIcon: Icons.thermostat,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
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
<<<<<<< HEAD
          tileIcon: Icons.health_and_safety, // Icono para el título
=======
          tileIcon: Icons.health_and_safety,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
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
<<<<<<< HEAD
          tileIcon: Icons.local_hospital, // Icono para el título
=======
          tileIcon: Icons.local_hospital,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
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
<<<<<<< HEAD
          tileIcon: Icons.air, // Icono para el título
=======
          tileIcon: Icons.air,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
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
<<<<<<< HEAD
    required IconData tileIcon, // Icono para el título
=======
    required IconData tileIcon,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
  }) {
    return ListTile(
      title: Row(
        children: [
<<<<<<< HEAD
          Icon(tileIcon), // Icono en el título
          const SizedBox(width: 8), // Espacio entre el icono y el texto
=======
          Icon(tileIcon),
          const SizedBox(width: 8),
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
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
<<<<<<< HEAD
                            evento: option['title'],
=======
                            subcategoria: title,
                            subsubcategoria: option['title'],
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
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

<<<<<<< HEAD
  // Método para construir cada `ListTile` dentro del `AlertDialog`
=======
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
  Widget buildDialogItem(
    BuildContext context,
    String title, {
    required String seccion,
    required String categoria,
<<<<<<< HEAD
    required String evento,
=======
    required String subcategoria,
    required String subsubcategoria,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
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
<<<<<<< HEAD
          Navigator.of(context).pop(); // Cierra el diálogo
=======
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
