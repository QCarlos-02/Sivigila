import 'package:flutter/material.dart';

class ReportesEnviados extends StatelessWidget {
  const ReportesEnviados({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExpansionTile(
      title: Text(
        'Funciones',
        style: TextStyle(fontSize: 18),
      ),
      children: [
        ListTile(
          title: Text('Reportes Enviados'),
        ),
      ],
    );
  }
}
