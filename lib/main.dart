import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sivigila/Admin/controllers/controlPerfil.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';
import 'package:sivigila/Admin/controllers/userController.dart';
import 'package:sivigila/Admin/pages/InicioAdmin.dart';
import 'package:sivigila/Pagina/Inicio.dart';
import 'package:sivigila/Pagina/login_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

void main() async {
  await GetStorage.init(); // Inicializa GetStorage
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  if (GetPlatform.isWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBagMvpkLEWK_w2-Pw2FLxQJbqkbyGilmU",
          authDomain: "sivigila-23d08.firebaseapp.com",
          projectId: "sivigila-23d08",
          storageBucket: "sivigila-23d08.appspot.com",
          messagingSenderId: "865111821241",
          appId: "1:865111821241:web:0e7c0d0fe48e1b16f48468"),
    );
  } else {
    await Firebase
        .initializeApp(); // Inicializa Firebase para otras plataformas
  }
  Get.put(Controlperfil());
  Get.put(ControlUserAuth());
  Get.put(Reportecontroller());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIVIGILA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthenticationWrapper(),
    );
  }
}

// Widget para manejar la autenticación
class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), // Escucha el estado de autenticación
      builder: (context, snapshot) {
        // Si el usuario está autenticado, redirigir a la página principal
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return const LoginPage(); // Si no está autenticado, mostrar el login
          } else {
            return const Pagina02(); // Si está autenticado, redirigir a la página de inicio
          }
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
