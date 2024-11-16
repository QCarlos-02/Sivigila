import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'dart:html' as html; // Solo para la web
import 'package:sivigila/Admin/controllers/reporteController.dart';
import 'package:sivigila/Models/reporte.dart';

class DetallesReporteScreen extends StatefulWidget {
  final Reporte reporte;
  final String? estado;

  const DetallesReporteScreen({required this.reporte, this.estado, super.key});

  @override
  _DetallesReporteScreenState createState() => _DetallesReporteScreenState();
}

class _DetallesReporteScreenState extends State<DetallesReporteScreen> {
  final Reportecontroller rp = Get.find();
  late TextEditingController observacionesController;
  String? estadoSeleccionado;

  @override
  void initState() {
    super.initState();
    estadoSeleccionado = widget.reporte.estado;
    observacionesController =
        TextEditingController(text: widget.reporte.observaciones);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalles del Reporte',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: exportarAExcel, // Botón para exportar a Excel
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            _buildCard(
              backgroundColor: Colors.lightBlue[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(
                      'Información General', Colors.blueGrey[800]),
                  const SizedBox(height: 16),
                  _buildInformationRow(
                      Icons.person, 'Nombres', widget.reporte.nombres),
                  const SizedBox(height: 8),
                  _buildInformationRow(Icons.person_outline, 'Apellidos',
                      widget.reporte.apellidos),
                  const SizedBox(height: 8),
                  _buildInformationRow(
                      Icons.date_range, 'Fecha Índice', widget.reporte.fecha),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Ubicación', Colors.blueGrey[800]),
                  const SizedBox(height: 16),
                  _buildInformationRow(
                      Icons.location_city, 'Comuna', widget.reporte.comuna),
                  const SizedBox(height: 8),
                  _buildInformationRow(
                      Icons.home, 'Barrio', widget.reporte.barrio),
                  const SizedBox(height: 8),
                  _buildInformationRow(
                      Icons.map, 'Dirección', widget.reporte.direccion),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Detalles', Colors.blueGrey[800]),
                  const SizedBox(height: 16),
                  _buildInformationRow(
                      Icons.category, 'Categoría', widget.reporte.categoria),
                  const SizedBox(height: 8),
                  _buildInformationRow(
                      Icons.label, 'Subcategoría', widget.reporte.subcategoria),
                  const SizedBox(height: 8),
                  _buildInformationRow(Icons.description, 'Descripción',
                      widget.reporte.descripcion),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              backgroundColor: Colors.lightGreen[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(
                      'Comentarios del Referente', Colors.green[800]),
                  const SizedBox(height: 8),
                  _buildComentRefSection(widget.reporte.comentRef),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              backgroundColor: Colors.orange[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Actualizar Estado', Colors.orange[800]),
                  const SizedBox(height: 8),
                  _buildDropdownField('Estado', estadoSeleccionado),
                  const SizedBox(height: 20),
                  _buildSectionTitle('Observaciones', Colors.orange[800]),
                  const SizedBox(height: 8),
                  _buildEditableField(observacionesController),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        var datos = {
                          'estado': estadoSeleccionado,
                          'observaciones': observacionesController.text
                        };
                        rp.actualizarReporte(widget.reporte.id, datos);
                        rp.consultarReportesgeneral();
                        if (widget.estado != null) {
                          rp.consultarReportesPorEstado(widget.estado!);
                        }
                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[900],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Guardar Cambios',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función para exportar a Excel
  void exportarAExcel() async {
    final workbook = xlsio.Workbook();
    final sheet = workbook.worksheets[0];

    // Encabezados
    List<String> headers = [
      'Nombres',
      'Apellidos',
      'Fecha Índice',
      'Comuna',
      'Barrio',
      'Dirección',
      'Categoría',
      'Subcategoría',
      'Descripción',
      'Comentario Referente',
      'Estado'
    ];
    for (int i = 0; i < headers.length; i++) {
      sheet.getRangeByIndex(1, i + 1).setText(headers[i]);
    }

    // Datos del reporte
    List<String> data = [
      widget.reporte.nombres ?? '',
      widget.reporte.apellidos ?? '',
      widget.reporte.fecha ?? '',
      widget.reporte.comuna ?? '',
      widget.reporte.barrio ?? '',
      widget.reporte.direccion ?? '',
      widget.reporte.categoria ?? '',
      widget.reporte.subcategoria ?? '',
      widget.reporte.descripcion ?? '',
      widget.reporte.comentRef?.join(', ') ??
          'Sin comentarios', // Comentarios del referente
      estadoSeleccionado ?? ''
    ];
    for (int i = 0; i < data.length; i++) {
      sheet.getRangeByIndex(2, i + 1).setText(data[i]);
    }

    // Guardar el archivo
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if (kIsWeb) {
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..style.display = 'none'
        ..download = 'reporte.xlsx';
      html.document.body!.children.add(anchor);
      anchor.click();
      html.document.body!.children.remove(anchor);
      html.Url.revokeObjectUrl(url);
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/reporte.xlsx');
      await file.writeAsBytes(bytes, flush: true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Archivo Excel guardado en: ${file.path}')),
      );
    }
  }

  Widget _buildCard({required Widget child, Color? backgroundColor}) {
    return Card(
      color: backgroundColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color? color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _buildEditableField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        hintText: 'Añadir observaciones',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      maxLines: 3,
    );
  }

  Widget _buildInformationRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueGrey),
        const SizedBox(width: 8),
        Expanded(
          child: _buildInformationItem(label, value),
        ),
      ],
    );
  }

  Widget _buildComentRefSection(List<String>? comentarios) {
    if (comentarios == null || comentarios.isEmpty) {
      return const Text(
        'No hay comentarios del referente',
        style: TextStyle(fontSize: 14, color: Colors.grey),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: comentarios.map((comentario) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            '- $comentario',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInformationItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String? value) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      items: ['Pendiente', 'En Proceso', 'Exitoso', 'Fallido', 'Descartado']
          .map((String estado) {
        return DropdownMenuItem<String>(
          value: estado,
          child: Text(
            estado,
            style: const TextStyle(color: Colors.black87, fontSize: 14),
          ),
        );
      }).toList(),
      onChanged: (String? nuevoEstado) {
        setState(() {
          estadoSeleccionado = nuevoEstado;
        });
      },
    );
  }
}
