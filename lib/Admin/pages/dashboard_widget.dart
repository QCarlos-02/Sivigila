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
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 20),
          Obx(() {
            // Usamos los datos observables del Reportecontroller
            final datosOriginales = reporteController.listgeneral ?? [];

            final pendientes = datosOriginales
                .where((reporte) => reporte.estado == 'Pendiente')
                .toList();
            final exitosos = datosOriginales
                .where((reporte) => reporte.estado == 'Exitoso')
                .toList();
            final enProceso = datosOriginales
                .where((reporte) => reporte.estado == 'En Proceso')
                .toList();
            final fallidos = datosOriginales
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
                      padding: const EdgeInsets.all(16),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
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
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 28),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text('Pend.');
                    case 1:
                      return const Text('Éxito');
                    case 2:
                      return const Text('Proc.');
                    case 3:
                      return const Text('Fall.');
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
                toY: pendingCount.toDouble(),
                color: Colors.orange,
              )
            ]),
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(
                toY: successfulCount.toDouble(),
                color: Colors.green,
              )
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(
                toY: inProcessCount.toDouble(),
                color: Colors.blue,
              )
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(
                toY: failedCount.toDouble(),
                color: Colors.red,
              )
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
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: pendingCount.toDouble(),
              color: Colors.orange,
              title: '$pendingCount',
              radius: 50,
            ),
            PieChartSectionData(
              value: successfulCount.toDouble(),
              color: Colors.green,
              title: '$successfulCount',
              radius: 50,
            ),
            PieChartSectionData(
              value: inProcessCount.toDouble(),
              color: Colors.blue,
              title: '$inProcessCount',
              radius: 50,
            ),
            PieChartSectionData(
              value: failedCount.toDouble(),
              color: Colors.red,
              title: '$failedCount',
              radius: 50,
            ),
          ],
          borderData: FlBorderData(show: false),
          centerSpaceRadius: 40,
        ),
      ),
    );
  }
}
