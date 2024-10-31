import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';
import 'package:sivigila/Admin/pages/DetallesReportes.dart';

// ignore: must_be_immutable
class Reportes extends StatefulWidget {
  String estado;
  Reportes({super.key, required this.estado});

  @override
  State<Reportes> createState() => _ReportesState();
}

class _ReportesState extends State<Reportes> {
  Reportecontroller rp = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.estado);
    rp.consultarReportesPorEstado(widget.estado);
  }

  @override
  Widget build(BuildContext context) {
    //rp.consultarReportesPorEstado(widget.estado);
    return Obx(() {
      if (rp.listReportes == null || rp.listReportes!.isEmpty) {
        return const Center(
          child: Text("NO HAY REPORTES"),
        );
      } else {
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: rp.listReportes!.length,
          itemBuilder: (BuildContext context, int index) {
            final reporte = rp.listReportes![index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contenedor de la información del reporte
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sección: ${reporte.seccion}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Categoría: ${reporte.categoria}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Subcategoría: ${reporte.subcategoria ?? "N/A"}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Sub-subcategoría: ${reporte.subsubcategoria ?? "N/A"}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    // Botón "Visualizar Reporte" alineado a la derecha
                    Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Aquí navegas a la pantalla de detalles del reporte
                          final resultado = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetallesReporteScreen(
                                reporte: reporte,
                                estado: widget.estado,
                              ),
                            ),
                          );
                          if (resultado == true) {
                            rp.consultarReportesPorEstado(widget.estado);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: const Text(
                          'Visualizar',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }
}
