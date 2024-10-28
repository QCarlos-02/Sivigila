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
<<<<<<< HEAD
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
=======
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Inicializa GetStorage

  // Inicializa Firebase
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

>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
=======
    return GetMaterialApp(
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
      debugShowCheckedModeBanner: false,
      title: 'SIVIGILA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
<<<<<<< HEAD
      home: const LoginPage(),
=======
      home: const AuthenticationWrapper(),
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
    );
  }
}

<<<<<<< HEAD
// Widget para manejar la autenticación
=======
// Wrapper para manejar la autenticación
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
<<<<<<< HEAD
      stream: FirebaseAuth.instance
          .authStateChanges(), // Escucha el estado de autenticación
      builder: (context, snapshot) {
        // Si el usuario está autenticado, redirigir a la página principal
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return const LoginPage(); // Si no está autenticado, mostrar el login
          } else {
            return const Pagina02();
            // Si está autenticado, redirigir a la página de inicio
          }
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
=======
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
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
      },
    );
  }
}
<<<<<<< HEAD
=======

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
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
