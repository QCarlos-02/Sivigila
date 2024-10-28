import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';

class DashboardWidget extends StatelessWidget {
  DashboardWidget({super.key});

  final Reportecontroller reporteController = Get.put(Reportecontroller());

  @override
  Widget build(BuildContext context) {
    // Llama a la función para consultar los reportes generales
    reporteController.consultarReportesgeneral();

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 18),
          const Text(
            "Bienvenido, Administrador",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Obx(() {
            // Filtrar los reportes por estado
            final pendientes = reporteController.listgeneral!
                .where((reporte) => reporte.estado == 'Pendiente')
                .toList();
            final exitosos = reporteController.listgeneral!
                .where((reporte) => reporte.estado == 'Exitoso')
                .toList();
            final enProceso = reporteController.listgeneral!
                .where((reporte) => reporte.estado == 'En Proceso')
                .toList();
            final fallidos = reporteController.listgeneral!
                .where((reporte) => reporte.estado == 'Fallido')
                .toList();

            return Expanded(
              child: GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: const EdgeInsets.all(10),
                children: [
                  _buildCard(
                      "Casos Pendientes", pendientes.length, Colors.orange),
                  _buildCard("Casos Exitosos", exitosos.length, Colors.green),
                  _buildCard("Casos en Proceso", enProceso.length, Colors.blue),
                  _buildCard("Casos Fallidos", fallidos.length, Colors.red),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCard(String title, int count, Color color) {
    return SizedBox(
      height: 100, // Altura específica para cada tarjeta
      child: Card(
        color: color.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(10), // Reduce el padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold, color: color),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                  height: 5), // Reduce el espacio entre el título y el conteo
              Text(
                count.toString(),
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
