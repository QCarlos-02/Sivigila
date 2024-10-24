import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/data/services/userServices.dart';

class ControlUserAuth extends GetxController {
  final _response = Rxn();
  final _mensaje = "".obs;
  String? _uidUsuario;

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

  dynamic get estadoUser => _response.value;

  String? get idUsuario => _uidUsuario;

  UserCredential? get userValido => _usuario.value;
}
