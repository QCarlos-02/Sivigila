import 'package:flutter/material.dart';
import 'package:sivigila/Pagina/formulario_reporte.dart';

class SituacionAnimalesTile extends StatelessWidget {
  const SituacionAnimalesTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        'Situación en Animales',
        style: TextStyle(fontSize: 18),
      ),
      children: [
        _buildListTile(context, 'Mordidas y arañazos', Icons.pets,
            () => _showMordidasDialog(context)),
        _buildListTile(context, 'Envenenamiento o picadura', Icons.bug_report,
            () => _showEnvenenamientoDialog(context)),
        _buildListTile(context, 'Muerte Extraña', Icons.help,
            () => _showMuerteDialog(context)),
      ],
    );
  }

  Widget _buildListTile(
      BuildContext context, String title, IconData icon, Function onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => onTap(),
    );
  }

  void _showMordidasDialog(BuildContext context) {
    _showDialog(
      context,
      'Mordidas y arañazos',
      [
        _buildDialogListTile(
            context,
            'Mordedura Por Perro, Zorro O Zarigueya',
            Icons.dangerous,
            () => _navegarFormulario(
                  context,
                  seccion: 'Situación en Animales',
                  categoria: 'Mordidas y arañazos',
<<<<<<< HEAD
                  evento: 'Mordedura Por Perro, Zorro O Zarigueya',
=======
                  subcategoria: 'Mordeduras',
                  subsubcategoria: 'Mordedura Por Perro, Zorro O Zarigueya',
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
                )),
        _buildDialogListTile(
            context,
            'Mordedura De Serpiente',
            Icons.terrain,
            () => _navegarFormulario(
                  context,
                  seccion: 'Situación en Animales',
                  categoria: 'Mordidas y arañazos',
<<<<<<< HEAD
                  evento: 'Mordedura De Serpiente',
=======
                  subcategoria: 'Mordeduras',
                  subsubcategoria: 'Mordedura De Serpiente',
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
                )),
        _buildDialogListTile(
            context,
            'Mordeduras De Arañas',
            Icons.bug_report,
            () => _navegarFormulario(
                  context,
                  seccion: 'Situación en Animales',
                  categoria: 'Mordidas y arañazos',
<<<<<<< HEAD
                  evento: 'Mordeduras De Arañas',
=======
                  subcategoria: 'Mordeduras',
                  subsubcategoria: 'Mordeduras De Arañas',
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
                )),
        _buildDialogListTile(
            context,
            'Arañazos De Gatos',
            Icons.pets,
            () => _navegarFormulario(
                  context,
                  seccion: 'Situación en Animales',
                  categoria: 'Mordidas y arañazos',
<<<<<<< HEAD
                  evento: 'Arañazos De Gatos',
=======
                  subcategoria: 'Arañazos',
                  subsubcategoria: 'Arañazos De Gatos',
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
                )),
      ],
    );
  }

  void _showEnvenenamientoDialog(BuildContext context) {
    _showDialog(
      context,
      'Tipos De Envenenamiento o Picaduras',
      [
        _buildDialogListTile(
            context,
            'Picadura De Alacranes o Escorpiones',
            Icons.bug_report,
            () => _navegarFormulario(
                  context,
                  seccion: 'Situación en Animales',
                  categoria: 'Envenenamiento o picadura',
<<<<<<< HEAD
                  evento: 'Picadura De Alacranes o Escorpiones',
                )),
        _buildDialogListTile(
            context,
            'Contacto Con Animales Pozoñosos',
=======
                  subcategoria: 'Picaduras',
                  subsubcategoria: 'Picadura De Alacranes o Escorpiones',
                )),
        _buildDialogListTile(
            context,
            'Contacto Con Animales Ponzoñosos',
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
            Icons.bug_report,
            () => _navegarFormulario(
                  context,
                  seccion: 'Situación en Animales',
                  categoria: 'Envenenamiento o picadura',
<<<<<<< HEAD
                  evento: 'Contacto Con Animales Pozoñosos',
=======
                  subcategoria: 'Contacto Ponzoñoso',
                  subsubcategoria: 'Contacto Con Animales Ponzoñosos',
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
                )),
      ],
    );
  }

  void _showMuerteDialog(BuildContext context) {
    _showDialog(
      context,
      'Muerte Sin Razon',
      [
        _buildDialogListTile(
            context,
<<<<<<< HEAD
            'Contacto Con Un Animal Que Posteriormente Fallecio Sin Razon Aparente',
=======
            'Contacto Con Un Animal Que Posteriormente Falleció Sin Razón Aparente',
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
            Icons.report_problem,
            () => _navegarFormulario(
                  context,
                  seccion: 'Situación en Animales',
                  categoria: 'Muerte Extraña',
<<<<<<< HEAD
                  evento: 'Contacto Con Un Animal Que Falleció Sin Razón',
=======
                  subcategoria: 'Muerte Inesperada',
                  subsubcategoria:
                      'Contacto Con Un Animal Que Falleció Sin Razón Aparente',
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
                )),
      ],
    );
  }

  void _showDialog(BuildContext context, String title, List<Widget> children) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
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

  Widget _buildDialogListTile(
      BuildContext context, String title, IconData icon, Function onTap) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () => onTap(),
      ),
    );
  }

<<<<<<< HEAD
  // Método para navegar al formulario y pasar los datos
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
