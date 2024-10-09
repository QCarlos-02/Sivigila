import 'package:cloud_firestore/cloud_firestore.dart';
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
    var reference = FirebaseFirestore.instance.collection("reportes");
    var result = await reference.add({
      'seccion': seccion,
      'categoria': categoria,
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
  }
}
