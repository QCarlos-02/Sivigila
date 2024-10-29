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
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Inicializa GetStorage

  // Inicializa Firebase asd
  await Firebase.initializeApp(
    options: GetPlatform.isWeb
        ? const FirebaseOptions(
            apiKey: "AIzaSyBagMvpkLEWK_w2-Pw2FLxQJbqkbyGilmU",
            authDomain: "sivigila-23d08.firebaseapp.com",
            projectId: "sivigila-23d08",
            storageBucket: "sivigila-23d08.appspot.com",
            messagingSenderId: "865111821241",
            appId: "1:865111821241:web:0e7c0d0fe48e1b16f48468",
          )
        : null, // Inicializa Firebase para otras plataformas
  );

  // Registro de controladores con GetX
  Get.put(Controlperfil());
  Get.put(ControlUserAuth());
  Get.put(Reportecontroller());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIVIGILA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthenticationWrapper(),
    );
  }
}

// Wrapper para manejar la autenticación
class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Muestra pantalla de carga mientras se verifica el estado
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasData) {
          // Si el usuario está autenticado, redirigir a la página principal
          return const Pagina02();
        } else {
          // Si no está autenticado, mostrar la pantalla de login
          return const LoginPage();
        }
      },
    );
  }
}

// Pantalla de carga
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
