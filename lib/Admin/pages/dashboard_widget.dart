import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({super.key});

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  final Reportecontroller reporteController = Get.find();

  @override
  void initState() {
    super.initState();
    // Llama a la función para consultar los reportes generales al iniciar
    reporteController.consultarReportesgeneral();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          const Text(
            "Bienvenido, Administrador",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Obx(() {
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

            int pendingCount = pendientes.length;
            int successfulCount = exitosos.length;
            int inProcessCount = enProceso.length;
            int failedCount = fallidos.length;

            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.count(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 4 : 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildInfoCard(
                            "Pendientes", pendingCount, Colors.orange),
                        _buildInfoCard(
                            "Exitosos", successfulCount, Colors.green),
                        _buildInfoCard(
                            "En Proceso", inProcessCount, Colors.blue),
                        _buildInfoCard("Fallidos", failedCount, Colors.red),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildBarChart(pendingCount, successfulCount,
                        inProcessCount, failedCount), // Gráfico de barras
                    const SizedBox(height: 20),
                    _buildPieChart(pendingCount, successfulCount,
                        inProcessCount, failedCount), // Gráfico circular
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, int count, Color color) {
    return Container(
      width: 80, // Ancho específico para hacer la tarjeta más pequeña
      height: 60, // Altura de la tarjeta
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold, color: color),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              count.toString(),
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart(int pendingCount, int successfulCount,
      int inProcessCount, int failedCount) {
    return Container(
      height: 200, // Altura del gráfico de barras
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
        ],
      ),
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 38,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text('Pendientes');
                    case 1:
                      return const Text('Exitosos');
                    case 2:
                      return const Text('En Proceso');
                    case 3:
                      return const Text('Fallidos');
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(
                  toY: pendingCount.toDouble(), color: Colors.orange)
            ]),
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(
                  toY: successfulCount.toDouble(), color: Colors.green)
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(
                  toY: inProcessCount.toDouble(), color: Colors.blue)
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(toY: failedCount.toDouble(), color: Colors.red)
            ]),
          ],
          gridData: FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
        ),
      ),
    );
  }

  Widget _buildPieChart(int pendingCount, int successfulCount,
      int inProcessCount, int failedCount) {
    return Container(
      height: 200, // Altura del gráfico circular
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
        ],
      ),
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: pendingCount.toDouble(),
              color: Colors.orange,
              title: '${pendingCount}', // Mostrar valor real
              radius: 40,
            ),
            PieChartSectionData(
              value: successfulCount.toDouble(),
              color: Colors.green,
              title: '${successfulCount}', // Mostrar valor real
              radius: 40,
            ),
            PieChartSectionData(
              value: inProcessCount.toDouble(),
              color: Colors.blue,
              title: '${inProcessCount}', // Mostrar valor real
              radius: 40,
            ),
            PieChartSectionData(
              value: failedCount.toDouble(),
              color: Colors.red,
              title: '${failedCount}', // Mostrar valor real
              radius: 40,
            ),
          ],
          borderData: FlBorderData(show: false),
          centerSpaceRadius: 0,
        ),
      ),
    );
  }
}
