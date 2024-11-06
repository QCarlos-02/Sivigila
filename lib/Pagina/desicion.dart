import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sivigila/Admin/pages/InicioAdmin.dart';
import 'package:sivigila/Pagina/Inicio.dart';

class Desicion extends StatelessWidget {
  const Desicion({super.key});

  Future<String> getUserRole() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Obtener el documento en Firestore para este usuario
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('perfiles')
          .doc(user.uid)
          .get();

      // Verificar que el documento exista y tenga el campo 'rol'
      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>;
        return data['rol'] ?? "Rol no definido";
      } else {
        throw Exception("Documento de usuario no encontrado");
      }
    }
    throw Exception("Usuario no autenticado");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator()), // Indicador de carga
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
                child: Text("Error al obtener el rol: ${snapshot.error}")),
          );
        }

        if (snapshot.hasData) {
          String role = snapshot.data!;
          // Redirige según el rol
          if (role == 'Admin') {
            return const Pagina02();
          } else if (role == 'Lider') {
            return const LeftSection();
          } else {
            return const Scaffold(
              body: Center(child: Text("Rol no reconocido")),
            );
          }
        }

        return const Scaffold(
          body: Center(child: Text("Cargando...")),
        );
      },
    );
  }
}
