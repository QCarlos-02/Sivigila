import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/controllers/userController.dart';
import 'package:sivigila/Admin/pages/CasosEnProceso.dart';
import 'package:sivigila/Admin/pages/CasosFallidos.dart';
import 'package:sivigila/Admin/pages/Casosexitosos.dart';
import 'package:sivigila/Admin/pages/Casospendientes.dart';
import 'package:sivigila/Admin/pages/RegistroUsuario.dart';
import 'package:sivigila/Pagina/login_page.dart';

Widget drawer(BuildContext context) {
  ControlUserAuth cua = Get.find();
  final double screenWidth = MediaQuery.of(context).size.width;
  final bool isMobile = screenWidth < 600;

  return Drawer(
    backgroundColor: const Color.fromARGB(255, 0, 44, 81),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 0, 44, 81),
          ),
          child: Center(
            child: Text(
              'SIVIGILA',
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 24 : 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        _buildDrawerItem(
          context,
          icon: Icons.pending_actions_outlined,
          text: "Casos pendientes",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Casospendientes()),
            );
          },
        ),
        _buildDrawerItem(
          context,
          icon: Icons.double_arrow_rounded,
          text: "Casos en proceso",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Casosenproceso()),
            );
          },
        ),
        _buildDrawerItem(
          context,
          icon: Icons.check_circle_outline,
          text: "Casos exitosos",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Casosexitosos()),
            );
          },
        ),
        _buildDrawerItem(
          context,
          icon: Icons.archive,
          text: "Casos fallidos",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Casosfallidos()),
            );
          },
        ),
        _buildDrawerItem(
          context,
          icon: Icons.app_registration,
          text: "Registro de usuarios",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Registro()),
            );
          },
        ),
        const Divider(color: Colors.white54),
        _buildDrawerItem(
          context,
          icon: Icons.exit_to_app,
          text: "Salir",
          onTap: () {
            cua.cerrarSesion();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),
      ],
    ),
  );
}

Widget _buildDrawerItem(BuildContext context,
    {required IconData icon, required String text, required Function() onTap}) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final bool isMobile = screenWidth < 600;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: ListTile(
      leading: Icon(icon, color: Colors.white, size: isMobile ? 24 : 28),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: isMobile ? 16 : 18,
        ),
      ),
      onTap: onTap,
    ),
  );
}
