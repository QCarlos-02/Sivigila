import 'package:get/get.dart';
import 'package:sivigila/Models/reporte.dart';
import 'package:sivigila/Admin/data/services/reportesServices.dart';

class Reportecontroller extends GetxController {
  // Datos originales y versión filtrada
  final Rxn<List<Reporte>> _reporteOriginal = Rxn<List<Reporte>>([]);
  final Rxn<List<Reporte>> _reporteFiltrado = Rxn<List<Reporte>>([]);

  // Getter para obtener siempre los datos originales
  List<Reporte>? get listgeneral => _reporteOriginal.value;

  // Getter para reportes filtrados
  List<Reporte>? get listReportes => _reporteFiltrado.value;

  Future<void> consultarReportesgeneral() async {
    // Cargar los datos originales
    _reporteOriginal.value = await Reportesservices().listaReportes();
    _reporteFiltrado.value = List.from(_reporteOriginal.value!);

    print('Total de reportes cargados: ${_reporteOriginal.value?.length}');
  }

  Future<void> consultarReportesPorEstado(String estado) async {
    // Filtrar los datos originales en lugar de sobreescribirlos
    _reporteFiltrado.value = _reporteOriginal.value
        ?.where((reporte) => reporte.estado == estado)
        .toList();

    print(
        'Total de reportes con estado "$estado": ${_reporteFiltrado.value?.length}');
  }

  Future<void> actualizarReporte(String id, Map<String, dynamic> datos) async {
    await Reportesservices().actualizarReporte(id, datos);
  }

  void filtrarReportes(
      {String? categoria, String? subcategoria, String? subsubcategoria}) {
    if (_reporteOriginal.value == null) return;

    _reporteFiltrado.value = _reporteOriginal.value!.where((reporte) {
      final categoriaCoincide = categoria == null ||
          reporte.seccion.toLowerCase() == categoria.toLowerCase();
      final subcategoriaCoincide = subcategoria == null ||
          reporte.categoria.toLowerCase() == subcategoria.toLowerCase();
      final subsubcategoriaCoincide = subsubcategoria == null ||
          reporte.subsubcategoria.toLowerCase() ==
              subsubcategoria.toLowerCase();

      return categoriaCoincide &&
          subcategoriaCoincide &&
          subsubcategoriaCoincide;
    }).toList();

    print('Cantidad de reportes filtrados: ${_reporteFiltrado.value?.length}');
    update(); // Actualiza la vista después de aplicar el filtro
  }

  void limpiarFiltros() {
    _reporteFiltrado.value = List.from(_reporteOriginal.value!);
    update(); // Asegúrate de actualizar la vista
  }
}
