import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportesUsuario extends StatelessWidget {
  final String uidUsuario;

  const ReportesUsuario({super.key, required this.uidUsuario});

  Future<List<DocumentSnapshot>> obtenerReportesPorUID() async {
    QuerySnapshot reportes = await FirebaseFirestore.instance
        .collection('reportes')
        .where('userId', isEqualTo: uidUsuario)
        .get();

    return reportes.docs;
  }

  Map<String, List<DocumentSnapshot>> separarReportesPorEstado(
      List<DocumentSnapshot> reportes) {
    Map<String, List<DocumentSnapshot>> reportesPorEstado = {
      'exitoso': [],
      'fallido': [],
      'descartado': [],
      'en proceso': [],
      'pendiente': [],
    };

    for (var reporte in reportes) {
      String estado = reporte['estado']?.toLowerCase() ?? 'pendiente';
      if (reportesPorEstado.containsKey(estado)) {
        reportesPorEstado[estado]?.add(reporte);
      }
    }

    return reportesPorEstado;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis Reportes Enviados',
          style: TextStyle(
            fontFamily: 'Agenda',
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        elevation: 4.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade700,
              Colors.blue.shade500,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<DocumentSnapshot>>(
          future: obtenerReportesPorUID(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error al cargar los reportes'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No tienes reportes enviados'));
            }

            Map<String, List<DocumentSnapshot>> reportesPorEstado =
                separarReportesPorEstado(snapshot.data!);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: reportesPorEstado.keys.map((estado) {
                  List<DocumentSnapshot> reportes = reportesPorEstado[estado]!;
                  if (reportes.isEmpty) return Container();

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: obtenerColorPorEstado(estado)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              estado.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'Agenda',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: obtenerColorPorEstado(estado),
                                shadows: [
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: reportes.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot reporte = reportes[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ExpansionTile(
                                  tilePadding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  title: Row(
                                    children: [
                                      obtenerIconoPorEstado(estado),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          reporte['categoria'] ??
                                              'Sin categoría',
                                          style: TextStyle(
                                            fontFamily: 'Agenda',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    'Fecha del incidente: ${reporte['fecha_incidente'] ?? 'Sin fecha'}',
                                    style: TextStyle(
                                      fontFamily: 'Agenda',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  iconColor: Colors.blue[800],
                                  collapsedIconColor: Colors.blue[800],
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildDetailRow('Subcategoría',
                                              reporte['subcategoria']),
                                          _buildDetailRow(
                                              'Zona', reporte['zona']),
                                          _buildDetailRow('Comuna del evento',
                                              reporte['comuna_evento']),
                                          _buildDetailRow(
                                              'Barrio', reporte['barrio']),
                                          _buildDetailRow('Dirección',
                                              reporte['direccion']),
                                          _buildDetailRow('Descripción',
                                              reporte['descripcion']),
                                          _buildDetailRow(
                                            'Fecha de registro',
                                            reporte['timestamp'] != null
                                                ? (reporte['timestamp']
                                                        as Timestamp)
                                                    .toDate()
                                                    .toString()
                                                : 'Sin fecha',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }

  Color obtenerColorPorEstado(String estado) {
    switch (estado.toLowerCase()) {
      case 'exitoso':
        return Colors.green;
      case 'fallido':
        return Colors.red;
      case 'descartado':
        return Colors.brown;
      case 'en proceso':
        return Colors.yellow.shade700; // Color más oscuro para "en proceso"
      case 'pendiente':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Icon obtenerIconoPorEstado(String estado) {
    switch (estado.toLowerCase()) {
      case 'exitoso':
        return const Icon(Icons.check_circle, color: Colors.green);
      case 'fallido':
        return const Icon(Icons.error, color: Colors.red);
      case 'descartado':
        return const Icon(Icons.cancel, color: Colors.brown);
      case 'en proceso':
        return const Icon(Icons.hourglass_empty, color: Color(0xFFB8860B)); // Icono más oscuro
      case 'pendiente':
        return const Icon(Icons.schedule, color: Colors.orange);
      default:
        return const Icon(Icons.help, color: Colors.grey);
    }
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontFamily: 'Agenda',
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'No especificado',
              style: TextStyle(
                fontFamily: 'Agenda',
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
