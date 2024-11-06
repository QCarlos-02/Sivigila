import 'package:get/get.dart';
import 'package:sivigila/Models/reporte.dart';
import 'package:sivigila/Admin/data/services/reportesServices.dart';

class Reportecontroller extends GetxController {
  final Rxn<List<Reporte>> _reporteFirestore = Rxn<List<Reporte>>([]);
  final Rxn<List<Reporte>> _reporteFiltrado = Rxn<List<Reporte>>([]);

  List<Reporte>? get listgeneral =>
      _reporteFiltrado.value ?? _reporteFirestore.value;

  List<Reporte>? get listReportes =>
      _reporteFiltrado.value ?? _reporteFirestore.value;

  Future<void> consultarReportesgeneral() async {
    _reporteFirestore.value = await Reportesservices().listaReportes();
    _reporteFiltrado.value = _reporteFirestore.value;

    // Verificar si los datos se están cargando correctamente
    print('Total de reportes cargados: ${_reporteFirestore.value?.length}');
  }

  Future<void> consultarReportesPorEstado(String estado) async {
    _reporteFirestore.value =
        await Reportesservices().listaReportesPorRol(estado);
    _reporteFiltrado.value = _reporteFirestore.value;
  }

  Future<void> actualizarReporte(String id, Map<String, dynamic> datos) async {
    await Reportesservices().actualizarReporte(id, datos);
  }

  void filtrarReportes(
      {String? categoria, String? subcategoria, String? subsubcategoria}) {
    if (_reporteFirestore.value == null) return;

    _reporteFiltrado.value = _reporteFirestore.value!.where((reporte) {
      final categoriaCoincide = categoria == null ||
          reporte.seccion.toLowerCase() == categoria.toLowerCase();
      final subcategoriaCoincide = subcategoria == null ||
          reporte.categoria.toLowerCase() == subcategoria.toLowerCase();
      final subsubcategoriaCoincide = subsubcategoria == null ||
          reporte.subsubcategoria.toLowerCase() ==
              subsubcategoria.toLowerCase();

      print(
          'Reporte: ${reporte.seccion}, ${reporte.categoria}, ${reporte.subsubcategoria}');
      print(
          'Filtros aplicados: categoria=$categoria, subcategoria=$subcategoria, subsubcategoria=$subsubcategoria');
      print(
          'Coincide: ${categoriaCoincide && subcategoriaCoincide && subsubcategoriaCoincide}');

      return categoriaCoincide &&
          subcategoriaCoincide &&
          subsubcategoriaCoincide;
    }).toList();

    print('Cantidad de reportes filtrados: ${_reporteFiltrado.value?.length}');
    update(); // Actualiza la vista después de aplicar el filtro
  }

  void limpiarFiltros() {
    _reporteFiltrado.value = _reporteFirestore.value;
    update(); // Asegúrate de actualizar la vista
  }
}
