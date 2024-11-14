import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/controllers/userController.dart';
import 'package:sivigila/Admin/pages/CasosDescartados.dart';
import 'package:sivigila/Admin/pages/CasosEnProceso.dart';
import 'package:sivigila/Admin/pages/CasosFallidos.dart';
import 'package:sivigila/Admin/pages/Casosexitosos.dart';
import 'package:sivigila/Admin/pages/Casospendientes.dart';
import 'package:sivigila/Admin/pages/RegistroUsuario.dart';
import 'package:sivigila/Pagina/login_page.dart';

Widget drawer(BuildContext context) {
  final ControlUserAuth cua = Get.find(); // Obtén el controlador
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.account_circle,
                color: Colors.white,
                size: isMobile ? 50 : 60,
              ),
              const SizedBox(height: 10),
              // Usa Obx para observar cambios en el nombre del administrador
              Obx(() {
                String nombre = cua.adminName;
                return Text(
                  nombre,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 18 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              const SizedBox(height: 5),
              const Text(
                'Panel de Administrador',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        _buildDrawerItem(
          context,
          icon: Icons.pending_actions_outlined,
          text: "Reportes pendientes",
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
          text: "Reportes en proceso",
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
          text: "Reportes exitosos",
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
          text: "Reportes fallidos",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Casosfallidos()),
            );
          },
        ),
        _buildDrawerItem(context,
            icon: Icons.cancel, text: 'Reportes descartados', onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CasosDescartados()));
        }),
        const SizedBox(
          height: 20,
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
