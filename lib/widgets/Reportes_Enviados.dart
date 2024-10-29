import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sivigila/Pagina/reportes_usuario.dart'; // Importa la nueva página

class ReportesEnviados extends StatelessWidget {
  const ReportesEnviados({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(
        'Funciones',
        style: TextStyle(fontSize: 18),
      ),
      children: [
        ListTile(
          title: const Text('Reportes Enviados'),
          onTap: () {
            // Obtén el usuario actual
            final User? currentUser = FirebaseAuth.instance.currentUser;
            
            // Verifica si el usuario está autenticado
            if (currentUser != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportesUsuario(
                    uidUsuario: currentUser.uid, // Pasa el UID del usuario
                  ),
                ),
              );
            } else {
              // Muestra un mensaje si no hay un usuario autenticado
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Por favor, inicia sesión para ver el historial de reportes'),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
