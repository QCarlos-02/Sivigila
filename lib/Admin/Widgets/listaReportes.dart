import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';
<<<<<<< HEAD
import 'package:sivigila/Models/reporte.dart';
=======
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)

class Reportes extends StatelessWidget {
  const Reportes({super.key});

  @override
  Widget build(BuildContext context) {
    Reportecontroller rp = Get.find();
<<<<<<< HEAD
    rp.consultarReportesgeneral();
    return Container(
      child: Obx(() {
        if (rp.listgeneral!.isEmpty == true) {
          return const Center(
            child: Text("NO HAY REPORTES"),
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: rp.listgeneral!.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [Text(rp.listgeneral![index].categoria)],
              );
            },
          );
        }
      }),
    );
=======
    return Obx(() {
      if (rp.listgeneral == null || rp.listgeneral!.isEmpty) {
        return const Center(
          child: Text("NO HAY REPORTES"),
        );
      } else {
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: rp.listgeneral!.length,
          itemBuilder: (BuildContext context, int index) {
            final reporte = rp.listgeneral![index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(
                  'Sección: ${reporte.seccion}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Categoría: ${reporte.categoria}'),
                    Text('Subcategoría: ${reporte.subcategoria ?? "N/A"}'),
                    Text(
                        'Sub-subcategoría: ${reporte.subsubcategoria ?? "N/A"}'),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
>>>>>>> b4b31af (Se le da funcionalidad a la parte de registro de usuarios y a casos pendientes)
  }
}
