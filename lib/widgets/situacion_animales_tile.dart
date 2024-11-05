import 'package:flutter/material.dart';
import 'package:sivigila/Pagina/formulario_reporte.dart';

class SituacionAnimalesTile extends StatelessWidget {
  const SituacionAnimalesTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildListTile(
          context,
          'Mordidas y arañazos',
          Icons.pets,
          () => _showMordidasDialog(context),
        ),
        _buildListTile(
          context,
          'Envenenamiento o picadura',
          Icons.bug_report,
          () => _showEnvenenamientoDialog(context),
        ),
        _buildListTile(
          context,
          'Muerte Extraña',
          Icons.help,
          () => _showMuerteDialog(context),
        ),
      ],
    );
  }

  Widget _buildListTile(
    BuildContext context,
    String title,
    IconData icon,
    Function onTap,
  ) {
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
            subcategoria: 'Mordeduras',
            subsubcategoria: 'Mordedura Por Perro, Zorro O Zarigueya',
          ),
        ),
        _buildDialogListTile(
          context,
          'Mordedura De Serpiente',
          Icons.terrain,
          () => _navegarFormulario(
            context,
            seccion: 'Situación en Animales',
            categoria: 'Mordidas y arañazos',
            subcategoria: 'Mordeduras',
            subsubcategoria: 'Mordedura De Serpiente',
          ),
        ),
        _buildDialogListTile(
          context,
          'Mordeduras De Arañas',
          Icons.bug_report,
          () => _navegarFormulario(
            context,
            seccion: 'Situación en Animales',
            categoria: 'Mordidas y arañazos',
            subcategoria: 'Mordeduras',
            subsubcategoria: 'Mordeduras De Arañas',
          ),
        ),
        _buildDialogListTile(
          context,
          'Arañazos De Gatos',
          Icons.pets,
          () => _navegarFormulario(
            context,
            seccion: 'Situación en Animales',
            categoria: 'Mordidas y arañazos',
            subcategoria: 'Arañazos',
            subsubcategoria: 'Arañazos De Gatos',
          ),
        ),
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
            subcategoria: 'Picaduras',
            subsubcategoria: 'Picadura De Alacranes o Escorpiones',
          ),
        ),
        _buildDialogListTile(
          context,
          'Contacto Con Animales Ponzoñosos',
          Icons.bug_report,
          () => _navegarFormulario(
            context,
            seccion: 'Situación en Animales',
            categoria: 'Envenenamiento o picadura',
            subcategoria: 'Contacto Ponzoñoso',
            subsubcategoria: 'Contacto Con Animales Ponzoñosos',
          ),
        ),
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
          'Contacto Con Un Animal Que Posteriormente Falleció Sin Razón Aparente',
          Icons.report_problem,
          () => _navegarFormulario(
            context,
            seccion: 'Situación en Animales',
            categoria: 'Muerte Extraña',
            subcategoria: 'Muerte Inesperada',
            subsubcategoria: 'Contacto Con Un Animal Que Falleció Sin Razón Aparente',
          ),
        ),
      ],
    );
  }

  void _showDialog(BuildContext context, String title, List<Widget> children) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
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
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogListTile(
    BuildContext context,
    String title,
    IconData icon,
    Function onTap,
  ) {
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
        onTap: () => onTap(),
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
