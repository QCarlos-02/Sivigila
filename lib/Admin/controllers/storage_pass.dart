import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sivigila/Admin/pages/RegistroUsuario.dart';

final _auth = FirebaseAuth.instance;
const _storage = FlutterSecureStorage();

// Guardar la contraseña del administrador
Future<void> saveAdminPassword(String password) async {
  await _storage.write(key: 'adminPassword', value: password);
}

// Recuperar la contraseña del administrador
Future<String?> getAdminPassword() async {
  return await _storage.read(key: 'adminPassword');
}

// Crear nuevo usuario sin cerrar la sesión del administrador
Future<void> createNewUser(
  String email,
  String password,
  Map<String, dynamic> datos,
) async {
  // Guarda las credenciales del administrador
  User? currentAdmin = _auth.currentUser;
  String? adminEmail = currentAdmin?.email;
  String? adminPassword = await getAdminPassword();

  // Crear el nuevo usuario
  await _auth.createUserWithEmailAndPassword(email: email, password: password);
  print("correo usuario creado: ${_auth.currentUser!.email}");

  datos['uid'] = _auth.currentUser!.uid; //Registra el uid del usuario creado

  // Guardar los datos adicionales del nuevo usuario
  await guardarDatosAdicionales(FirebaseAuth.instance.currentUser!, datos);

  // Vuelve a iniciar sesión como administrador
  if (adminPassword != null) {
    await _auth.signOut(); // Cierra la sesión del nuevo usuario
    await _auth.signInWithEmailAndPassword(
        email: adminEmail!, password: adminPassword);
  }
}

// Llamar a esta función cuando el administrador inicie sesión por primera vez
Future<void> adminLogin(String email, String password) async {
  await _auth.signInWithEmailAndPassword(email: email, password: password);
  await saveAdminPassword(password);
}
