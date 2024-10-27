import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';
import 'package:sivigila/Models/reporte.dart';

class Reportes extends StatelessWidget {
  const Reportes({super.key});

  @override
  Widget build(BuildContext context) {
    Reportecontroller rp = Get.find();
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
  }
}
