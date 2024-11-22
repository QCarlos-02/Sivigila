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
  try {
    // Verifica si el administrador está autenticado
    User? currentAdmin = _auth.currentUser;
    String? adminEmail = currentAdmin?.email;
    String? adminPassword = await getAdminPassword();

    if (adminEmail == null || adminPassword == null) {
      throw Exception("No se encontraron credenciales del administrador.");
    }

    // Reautenticar al administrador si es necesario
    AuthCredential credential = EmailAuthProvider.credential(
      email: adminEmail,
      password: adminPassword,
    );
    await currentAdmin!.reauthenticateWithCredential(credential);

    // Crear el nuevo usuario
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("Usuario creado: ${userCredential.user!.email}");

    // Agregar UID al mapa de datos
    datos['uid'] = userCredential.user!.uid;

    // Guardar los datos adicionales en Firestore
    await guardarDatosAdicionales(userCredential.user!, datos);

    // Restaurar la sesión del administrador
    await _auth.signOut(); // Cierra la sesión del nuevo usuario
    await _auth.signInWithEmailAndPassword(
      email: adminEmail,
      password: adminPassword,
    );
    print("Sesión del administrador restaurada con éxito.");
  } catch (e) {
    print("Error al crear usuario: $e");
    rethrow; // Lanza el error nuevamente si necesitas manejarlo externamente.
  }
}

// Llamar a esta función cuando el administrador inicie sesión por primera vez
Future<void> adminLogin(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("Administrador autenticado: ${userCredential.user!.email}");
    await saveAdminPassword(password);
  } catch (e) {
    print("Error en el inicio de sesión del administrador: $e");
    rethrow;
  }
}
