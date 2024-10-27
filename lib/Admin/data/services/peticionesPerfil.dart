import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/controllers/userController.dart';

class Peticionesperfil {
  static final ControlUserAuth controlUserAuth = Get.find();
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> crearCatalogo(Map<String, dynamic> catalogo) async {
    await _db
        .collection('perfiles')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(catalogo)
        .catchError((e) {
      print(e);
    });
  }

  static Future<String> validarUser(String correo) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('perfiles')
        .where('correo', isEqualTo: correo)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first['rol'];
    } else {
      return "Usuario no encontrado";
    }
  }
}
