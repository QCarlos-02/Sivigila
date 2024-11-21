import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sivigila/Admin/controllers/controlPerfil.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';
import 'package:sivigila/Admin/controllers/userController.dart';
import 'package:sivigila/Pagina/desicion.dart';
import 'package:sivigila/Pagina/login_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  try {
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
          : null,
    );

    Get.put(Controlperfil());
    Get.put(ControlUserAuth());
    Get.put(Reportecontroller());

    runApp(const MyApp());
  } catch (e) {
    print("Error al inicializar Firebase: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {                 
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VIGILAPP',
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const ErrorScreen();
        } else if (snapshot.hasData) {
          return const Desicion();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              'Cargando...',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Ocurrió un error. Por favor, inténtalo de nuevo más tarde.',
          style: TextStyle(fontSize: 18, color: Colors.redAccent),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
