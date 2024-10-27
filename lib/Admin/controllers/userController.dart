import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/data/services/userServices.dart';
import 'package:sivigila/main.dart';

class ControlUserAuth extends GetxController {
  final _response = Rxn();
  final _mensaje = "".obs;
  final Rxn<String> _rol = Rxn<String>();
  String? _uidUsuario;
  String? rolUser;

  final Rxn<UserCredential> _usuario = Rxn<UserCredential>();

  Future<void> crearUsuario(String email, String pass) async {
    _response.value = await Userservices.crearRegistroUsuario(email, pass);
    print(_response.value);
    await controlUser(_response.value);
  }

  Future<void> ingresarUsuario(String email, String pass) async {
    _response.value = await Userservices.ingresarEmail(email, pass);
    print(_response.value);
    await controlUser(_response.value);
  }

  Future<void> cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
    _usuario.value = null;
  }

  Future<void> controlUser(dynamic respuesta) async {
    if (respuesta == null) {
      _mensaje.value = "No se completo la consulta";
    } else if (respuesta == "1" || respuesta == "2") {
      _mensaje.value = "Datos ingresados incorrectos";
    } else {
      _mensaje.value = "Proceso realido correctamente";
    }
  }

  Future<void> cargarRol(UserCredential user) async {
    var uid = user.user!.uid;
    _uidUsuario = uid;

    try {
      // Intenta obtener el documento varias veces si aún no existe
      DocumentSnapshot? userDoc;
      int retries = 5; // Número de intentos
      while (retries > 0) {
        userDoc = await FirebaseFirestore.instance
            .collection('perfiles')
            .doc(_uidUsuario)
            .get();

        // Si el documento existe, detiene el bucle
        if (userDoc.exists) break;

        // Si no existe, espera un momento antes de volver a intentar
        await Future.delayed(Duration(milliseconds: 500));
        retries--;
      }

      // Verifica si el documento existe y tiene datos válidos
      if (userDoc != null && userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>;
        rolUser = data['rol'];
        _rol.value = data['rol'];
      } else {
        print(
            "Error: El documento de usuario no se encontró o no contiene datos.");
      }
    } catch (e) {
      print("Error al cargar el rol del usuario: $e");
    }
  }

  // Future<void> cargarRol(UserCredential user) async {
  //   var uid = user.user!.uid;
  //   _uidUsuario = uid;
  //   var userDoc = await FirebaseFirestore.instance
  //       .collection('perfiles')
  //       .doc(_uidUsuario)
  //       .get();
  //   var data = userDoc.data() as Map<String, dynamic>;
  //   rolUser = data['rol'];
  //   _rol.value = data['rol'];
  // }

  Future<void> validarUser(UserCredential user) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('perfiles')
        .where('correo', isEqualTo: user.user!.email)
        .get();

    var validar = querySnapshot.docs.first['rol'];
    _uidUsuario = user.user!.uid;
    rolUser = validar;
    _rol.value = validar;
    print(validar);
  }

  dynamic get estadoUser => _response.value;

  String? get idUsuario => _uidUsuario;

  UserCredential? get userValido => _usuario.value;

  String? get rol => _rol.value;

  String? get role => rolUser;
}
