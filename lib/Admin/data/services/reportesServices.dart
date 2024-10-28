import 'package:cloud_firestore/cloud_firestore.dart';
<<<<<<< HEAD
import 'package:sivigila/Models/reporte.dart';

class Reportesservices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  final servRef = FirebaseFirestore.instance
      .collection('reportes')
      .withConverter(
          fromFirestore: (snapshot, _) =>
              Reporte.desdeDoc(snapshot.id, snapshot.data()!),
          toFirestore: (serv, _) => serv.toJson());

  Future<String> guardarReporte(
    String seccion,
    String categoria,
=======
import 'package:sivigila/Models/reporte.dart'; // Importa la clase Reporte

class Reportesservices {
  // Instancia de FirebaseFirestore para acceder a la base de datos
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> guardarReporte(
    String seccion,
    String categoria,
    String subcategoria,
    String subsubcategoria,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
    String evento,
    String fecha,
    String persona,
    String zona,
    String comuna,
    String barrio,
    String direccion,
    String descripcion,
    String estado,
  ) async {
<<<<<<< HEAD
    var reference = FirebaseFirestore.instance.collection("reportes");
    var result = await reference.add({
      'seccion': seccion,
      'categoria': categoria,
=======
    var reference = _db.collection("reportes");
    var result = await reference.add({
      'seccion': seccion,
      'categoria': categoria,
      'subcategoria': subcategoria,
      'subsubcategoria': subsubcategoria,
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
      'evento': evento,
      'fecha': fecha,
      'persona': persona,
      'zona': zona,
      'comuna': comuna,
      'barrio': barrio,
      'direccion': direccion,
      'descripcion': descripcion,
      'estado': estado
    });

<<<<<<< HEAD
    return Future.value(result.id);
  }

  static Future<List<Reporte>> listaReportes() async {
    QuerySnapshot querySnapshot = await _db.collection("reportes").get();
    List<Reporte> lista = [];
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      lista.add(Reporte.desdeDoc(doc.id, data));
    }
    return lista;
=======
    return result.id;
  }

  // Método para obtener la lista de reportes desde Firestore
  Future<List<Reporte>> listaReportes() async {
    var snapshot = await _db.collection("reportes").get();
    return snapshot.docs
        .map((doc) => Reporte.desdeDoc(doc.id, doc.data()))
        .toList();
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
  }
}
