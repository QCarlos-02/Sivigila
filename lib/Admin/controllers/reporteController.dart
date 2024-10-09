import 'package:get/get.dart';
import 'package:sivigila/Admin/data/services/reportesServices.dart';
import 'package:sivigila/Models/reporte.dart';

class Reportecontroller extends GetxController {
  final Rxn<List<Reporte>> _reporteFirestore = Rxn<List<Reporte>>([]);

  Future<void> consultarReportesgeneral() async {
    // validar el usuario autenticado

    _reporteFirestore.value = await Reportesservices.listaReportes();
  }

  List<Reporte>? get listgeneral => _reporteFirestore.value;
}
