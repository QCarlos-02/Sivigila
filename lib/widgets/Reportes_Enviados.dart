import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sivigila/Pagina/reportes_usuario.dart';

class ReportesEnviados extends StatelessWidget {
  const ReportesEnviados({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text(
            'Reportes Enviados',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          leading: const Icon(Icons.history, color: Colors.blueAccent),
          onTap: () async {
            // Obtén el usuario actual
            final User? currentUser = FirebaseAuth.instance.currentUser;

            // Verifica si el usuario está autenticado
            if (currentUser != null) {
              // Navega a la página de ReportesUsuario pasando el UID
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportesUsuario(
                    uidUsuario: currentUser.uid,
                  ),
                ),
              );
            } else {
              // Muestra un mensaje si no hay un usuario autenticado
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Por favor, inicia sesión para ver el historial de reportes',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.redAccent,
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
