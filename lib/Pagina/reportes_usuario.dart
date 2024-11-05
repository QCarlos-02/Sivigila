import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportesUsuario extends StatelessWidget {
  final String uidUsuario;

  const ReportesUsuario({Key? key, required this.uidUsuario}) : super(key: key);

  Future<List<DocumentSnapshot>> obtenerReportesPorUID() async {
    QuerySnapshot reportes = await FirebaseFirestore.instance
        .collection('reportes')
        .where('userId', isEqualTo: uidUsuario)
        .get();

    return reportes.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Reportes Enviados'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade600,
              Colors.blue.shade400,
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

            // Muestra la lista de reportes con estilo minimalista y diseño coherente
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                DocumentSnapshot reporte = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                      title: Text(
                        reporte['categoria'] ?? 'Sin categoría',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      subtitle: Text(
                        'Fecha del incidente: ${reporte['fecha_incidente'] ?? 'Sin fecha'}',
                        style: TextStyle(color: Colors.blue[300]),
                      ),
                      iconColor: Colors.blue[700],
                      collapsedIconColor: Colors.blue[700],
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow('Subcategoría', reporte['subcategoria']),
                              _buildDetailRow('Zona', reporte['zona']),
                              _buildDetailRow('Comuna del evento', reporte['comuna_evento']),
                              _buildDetailRow('Barrio', reporte['barrio']),
                              _buildDetailRow('Dirección', reporte['direccion']),
                              _buildDetailRow('Descripción', reporte['descripcion']),
                              _buildDetailRow(
                                'Fecha de registro',
                                reporte['timestamp'] != null
                                    ? (reporte['timestamp'] as Timestamp).toDate().toString()
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
            );
          },
        ),
      ),
    );
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
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'No especificado',
              style: TextStyle(color: Colors.blue[900]),
            ),
          ),
        ],
      ),
    );
  }
}
