import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';
import 'package:sivigila/Admin/pages/dashboard_widget.dart';
import 'package:sivigila/Admin/Widgets/Drawer.dart';

class Pagina02 extends StatefulWidget {
  const Pagina02({super.key});

  @override
  State<Pagina02> createState() => _Pagina02State();
}

class _Pagina02State extends State<Pagina02> {
  late final GlobalKey<ScaffoldState> _scaffoldKey;
  final Reportecontroller reportecontroller = Reportecontroller();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    reportecontroller.consultarReportesgeneral();
    print(
        "Correo: ${_auth.currentUser!.email}, Uid: ${_auth.currentUser!.uid}");
  }

  @override
  Widget build(BuildContext context) {
    // Obtiene el ancho de la pantalla
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          iconSize: isMobile ? 24 : 30,
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/logo_left.png',
              height: isMobile ? 24 : 30,
            ),
            const SizedBox(width: 10),
            Text(
              'Dashboard',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 18 : 24, // Tamaño de fuente adaptativo
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              bool shouldLogout = await _showLogoutConfirmationDialog(context);
              if (shouldLogout) {
                await _auth.signOut();
                Navigator.pushReplacementNamed(context, '/');
              }
            },
            iconSize:
                isMobile ? 24 : 30, // Tamaño del ícono de cierre de sesión
          ),
        ],
      ),
      drawer: drawer(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 12.0 : 24.0),
          child: const DashboardWidget(),
        ),
      ),
    );
  }

  Future<bool> _showLogoutConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirmación',
            style: TextStyle(color: Colors.blueAccent),
          ),
          content: const Text('¿Está seguro de que desea cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Cerrar sesión',
                  style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }
}
