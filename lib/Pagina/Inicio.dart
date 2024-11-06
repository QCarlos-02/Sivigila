import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sivigila/widgets/Casos_Especificos.dart';
import 'package:sivigila/widgets/Conglomerados.dart';
import 'package:sivigila/widgets/Factores_Potencialmente_Relacionados.dart';
import 'package:sivigila/widgets/Muertes_Comunidad.dart';
import 'package:sivigila/widgets/Reportes_Enviados.dart';
import 'package:sivigila/widgets/Sindromes.dart';
import 'package:sivigila/widgets/situacion_animales_tile.dart';

class LeftSection extends StatelessWidget {
  const LeftSection({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Está seguro de que desea cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cerrar el diálogo
              child: const Text('Cancelar',
                  style: TextStyle(color: Colors.blueAccent)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Cerrar el diálogo
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('Cerrar sesión',
                  style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo_left.png',
              height: 30,
            ),
            const SizedBox(width: 10),
            const Text(
              'Inicio',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: 'Cerrar sesión',
            onPressed: () => _confirmLogout(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade600,
              Colors.blue.shade400,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildHeader(),
                const SizedBox(height: 10),
                _buildExpandableTile(
                  title: 'Reportes Enviados',
                  content: const ReportesEnviados(),
                ),
                _buildExpandableTile(
                  title: 'Factores Potenciales',
                  content: const FactoresPotencialmenteRelacionados(),
                ),
                _buildExpandableTile(
                  title: 'Situación de Animales',
                  content: const SituacionAnimalesTile(),
                ),
                _buildExpandableTile(
                  title: 'Síndromes',
                  content: const Sindromes(),
                ),
                _buildExpandableTile(
                  title: 'Casos Específicos',
                  content: const CasosEspecificos(),
                ),
                _buildExpandableTile(
                  title: 'Muertes en la Comunidad',
                  content: const MuertesComunidad(),
                ),
                _buildExpandableTile(
                  title: 'Conglomerados',
                  content: const Conglomerados(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: const Row(
          children: [
            Icon(Icons.report_problem, size: 40, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Reportes de SIVIGILA',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableTile(
      {required String title, required Widget content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        color: Colors.white.withOpacity(0.85),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
          title: Row(
            children: [
              const Icon(Icons.chevron_right, color: Colors.blueAccent),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: content, // Aquí se despliega el contenido del widget
            ),
          ],
        ),
      ),
    );
  }
}
