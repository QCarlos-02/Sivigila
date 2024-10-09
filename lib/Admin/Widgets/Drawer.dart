import 'package:flutter/material.dart';
import 'package:sivigila/Admin/pages/CasosEnProceso.dart';
import 'package:sivigila/Admin/pages/CasosFallidos.dart';
import 'package:sivigila/Admin/pages/Casosexitosos.dart';
import 'package:sivigila/Admin/pages/Casospendientes.dart';
import 'package:sivigila/Pagina/RegistroUsuario.dart';
import 'package:sivigila/Pagina/login_page.dart';

Widget drawer(BuildContext context) {
  return Drawer(
    backgroundColor: const Color.fromARGB(255, 0, 44, 81),
    child: Column(
      children: [
        const Padding(padding: EdgeInsets.symmetric(vertical: 25)),
        ListTile(
          leading: const Icon(
            Icons.pending_actions_outlined,
            color: Colors.white,
          ),
          title: const Text(
            "Casos pendientes",
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Casospendientes()));
          },
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
        ListTile(
          leading: const Icon(
            Icons.double_arrow_rounded,
            color: Colors.white,
          ),
          title: const Text("Casos en proceso",
              style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Casosenproceso()));
          },
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
        ListTile(
          leading: const Icon(
            Icons.check_circle_outline,
            color: Colors.white,
          ),
          title: const Text("Casos exitosos",
              style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Casosexitosos()));
          },
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
        ListTile(
          leading: const Icon(
            Icons.archive,
            color: Colors.white,
          ),
          title: const Text("Casos fallidos",
              style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Casosfallidos()));
          },
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
        ListTile(
          leading: const Icon(
            Icons.app_registration,
            color: Colors.white,
          ),
          title: const Text("Registro de usuarios",
              style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Registrousuario()));
          },
        ),
        const SizedBox(
          height: 35,
        ),
        ListTile(
          leading: const Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          title: const Text("Salir", style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ],
    ),
  );
}
