import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sivigila/Models/user.dart';

class Userservices {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  //REGISTRO DE USUARIOS
  static Future<dynamic> crearRegistroUsuario(
      dynamic email, dynamic pass) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      print("funcion$user");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("contraseña debil");
        return '1';
      } else if (e.code == 'email-already-in-use') {
        print('Correo ya existe');
        return '2';
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> ingresarEmail(dynamic email, dynamic pass) async {
    try {
      UserCredential user =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("Correo no encontrado");
        return '1';
      } else if (e.code == 'wrong-password') {
        print('Contraseña incorrecta');
        return '2';
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Usuarios>> listaUsuarios() async {
    try {
      var snapshot = await _db.collection("perfiles").get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        if (data['rol'] == 'Lider') {
          // Si el usuario es un líder, crea una instancia de Leader
          return Leader.desdeDoc(doc.id, data);
        } else {
          // Si el usuario es un admin o referente, crea una instancia de User
          return Usuarios.desdeDoc(doc.id, data);
        }
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<void> actualizarPerfil(
      String id, Map<String, dynamic> data) async {
    await _db.collection('perfiles').doc(id).update(data).catchError((e) {
      print(e);
    });
  }

  static Future<void> eliminarPerfil(String id) async {
    await _db.collection('perfiles').doc(id).delete().catchError((e) {
      print(e);
    });
  }
}
