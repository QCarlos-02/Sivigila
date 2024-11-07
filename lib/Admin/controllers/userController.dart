import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../data/services/userServices.dart';

class ControlUserAuth extends GetxController {
  final _response = Rxn();
  final _mensaje = "".obs;
  final Rxn<String> _rol = Rxn<String>();
  final Rxn<String> _adminName = Rxn<String>(); // Para almacenar el nombre del administrador
  String? _uid;
  String? rolUser;

  final Rxn<UserCredential> _usuario = Rxn<UserCredential>();

  Future<void> crearUsuario(String email, String pass) async {
    _response.value = await Userservices.crearRegistroUsuario(email, pass);
    await controlUser(_response.value);
  }

  Future<void> ingresarUsuario(String email, String pass) async {
    _response.value = await Userservices.ingresarEmail(email, pass);
    await controlUser(_response.value);
    await cargarDatosUsuarioPorUid(); // Cargar el nombre y rol del usuario usando uid
  }

  Future<void> cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
    _usuario.value = null;
  }

  Future<void> controlUser(dynamic respuesta) async {
    if (respuesta == null) {
      _mensaje.value = "No se completó la consulta";
    } else if (respuesta == "1" || respuesta == "2") {
      _mensaje.value = "Datos ingresados incorrectos";
    } else {
      _mensaje.value = "Proceso realizado correctamente";
    }
  }

  // Método para cargar datos del usuario usando la uid
  Future<void> cargarDatosUsuarioPorUid() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _uid = user.uid;

      // Consulta a Firestore para obtener el perfil del usuario por uid
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('perfiles')
          .doc(_uid)
          .get();

      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>;

        // Actualiza el rol y el nombre del administrador
        rolUser = data['rol'];
        _rol.value = data['rol'];
        _adminName.value = data['nombres'];
      }
    }
  } catch (e) {
    // Manejar errores si es necesario
  }
}


  dynamic get estadoUser => _response.value;

  String? get idUsuario => _uid;

  UserCredential? get userValido => _usuario.value;

  String? get rol => _rol.value;

  String get adminName => _adminName.value ?? "Administrador";
}
