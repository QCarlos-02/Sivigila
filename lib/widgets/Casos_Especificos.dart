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
<<<<<<< HEAD
              evento: 'VIH',
=======
              subcategoria: 'ETS',
              subsubcategoria: 'VIH',
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
            ),
            _buildDialogItem(
              context,
              'Sífilis',
              Icons.health_and_safety,
              seccion: 'Casos Específicos',
              categoria: 'Enfermedades de Transmisión Sexual',
<<<<<<< HEAD
              evento: 'Sífilis',
=======
              subcategoria: 'ETS',
              subsubcategoria: 'Sífilis',
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
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
<<<<<<< HEAD
              evento: 'Covid-19',
=======
              subcategoria: 'Infección',
              subsubcategoria: 'Covid-19',
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
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
<<<<<<< HEAD
              evento: 'Malaria',
=======
              subcategoria: 'Vector',
              subsubcategoria: 'Malaria',
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
            ),
            _buildDialogItem(
              context,
              'Leishmaniasis',
              Icons.bug_report,
              seccion: 'Casos Específicos',
              categoria: 'Enfermedades Transmitidas por Vectores',
<<<<<<< HEAD
              evento: 'Leishmaniasis',
=======
              subcategoria: 'Vector',
              subsubcategoria: 'Leishmaniasis',
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
            ),
            _buildDialogItem(
              context,
              'Dengue',
              Icons.bug_report,
              seccion: 'Casos Específicos',
              categoria: 'Enfermedades Transmitidas por Vectores',
<<<<<<< HEAD
              evento: 'Dengue',
=======
              subcategoria: 'Vector',
              subsubcategoria: 'Dengue',
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
            ),
            _buildDialogItem(
              context,
              'Chagas',
              Icons.bug_report,
              seccion: 'Casos Específicos',
              categoria: 'Enfermedades Transmitidas por Vectores',
<<<<<<< HEAD
              evento: 'Chagas',
=======
              subcategoria: 'Vector',
              subsubcategoria: 'Chagas',
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
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
<<<<<<< HEAD
              evento: 'Desnutrición',
=======
              subcategoria: 'Nutrición',
              subsubcategoria: 'Desnutrición',
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
<<<<<<< HEAD
    required String evento,
=======
    required String subcategoria,
    required String subsubcategoria,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
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
