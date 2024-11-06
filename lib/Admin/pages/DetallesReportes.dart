import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    observacionesController =
        TextEditingController(text: widget.reporte.observaciones);
    estadoSeleccionado = widget.reporte.estado;
  }

  @override
  void dispose() {
    observacionesController.dispose();
    super.dispose();
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0), // Espacio lateral añadido
        child: ListView(
          // Cambiado a ListView para desplazamiento vertical
          children: [
            _buildSectionTitle('Información del Reporte'),
            const SizedBox(height: 16), // Espacio entre título y contenido
            Center(
              // Centramos la sección
              child: _buildPlainTextField('Sección', widget.reporte.seccion),
            ),
            const SizedBox(height: 8), // Espacio entre filas
            _buildInformationRow(
              'Nombres',
              widget.reporte.nombres,
              'Apellidos',
              widget.reporte.apellidos,
              'Fecha Índice',
              widget.reporte.fecha,
            ),
            const SizedBox(height: 8), // Espacio entre filas
            _buildInformationRow(
              'Comuna',
              widget.reporte.comuna,
              'Barrio',
              widget.reporte.barrio,
              'Dirección',
              widget.reporte.direccion,
              'Zona',
              widget.reporte.zona,
            ),
            const SizedBox(height: 8), // Espacio entre filas
            _buildInformationRow(
              'Categoría',
              widget.reporte.categoria,
              'Subcategoría',
              widget.reporte.subcategoria,
              'Sub-subcategoría',
              widget.reporte.subsubcategoria,
            ),
            const SizedBox(height: 8), // Espacio entre filas
            Center(
              // Centramos la Descripción
              child: _buildPlainTextField(
                  'Descripción', widget.reporte.descripcion),
            ),
            const SizedBox(height: 16), // Espacio antes de la siguiente sección
            _buildSectionTitle('Actualizar Estado'),
            const SizedBox(height: 8),
            _buildDropdownField('Estado', estadoSeleccionado),
            const SizedBox(height: 16),
            _buildSectionTitle('Observaciones'),
            const SizedBox(height: 8),
            _buildEditableField(observacionesController),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  actualizarReporte(context);
                  rp.consultarReportesgeneral();
                  if (widget.estado != null) {
                    rp.consultarReportesPorEstado(widget.estado!);
                  }
                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[900],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
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
    );
  }

  Widget _buildInformationRow(String label1, String value1,
      [String? label2,
      String? value2,
      String? label3,
      String? value3,
      String? label4,
      String? value4]) {
    return Row(
      mainAxisSize: MainAxisSize
          .min, // Se asegura de que la fila no se expanda más de lo necesario
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildPlainTextField(label1, value1)),
        const SizedBox(width: 8), // Espacio reducido entre columnas
        if (label2 != null && value2 != null)
          Expanded(child: _buildPlainTextField(label2, value2)),
        if (label3 != null && value3 != null)
          const SizedBox(width: 8), // Espacio reducido entre columnas
        if (label3 != null && value3 != null)
          Expanded(child: _buildPlainTextField(label3, value3)),
        if (label4 != null && value4 != null)
          const SizedBox(width: 8), // Espacio reducido entre columnas
        if (label4 != null && value4 != null)
          Expanded(child: _buildPlainTextField(label4, value4)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Center(
      // Centramos el título
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey[800],
        ),
      ),
    );
  }

  Widget _buildPlainTextField(String label, String value) {
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
      items: ['Pendiente', 'En Proceso', 'Exitoso', 'Fallido']
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

  void actualizarReporte(BuildContext context) async {
    try {
      await Reportecontroller().actualizarReporte(widget.reporte.id, {
        "estado": estadoSeleccionado,
        "observaciones": observacionesController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Reporte actualizado correctamente")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al actualizar el reporte")),
      );
    }
  }
}
