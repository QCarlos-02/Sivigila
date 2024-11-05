import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sivigila/Admin/controllers/reporteController.dart';
import 'package:sivigila/Models/reporte.dart';

class DetallesReporteScreen extends StatefulWidget {
  final Reporte reporte;
  final String? estado;

  const DetallesReporteScreen({required this.reporte, this.estado, Key? key})
      : super(key: key);

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
    observacionesController = TextEditingController(text: widget.reporte.observaciones);
    estadoSeleccionado = widget.reporte.estado;
  }

  @override
  void dispose() {
    observacionesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalles del Reporte',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[900],
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade50, Colors.blueGrey.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(isMobile ? 16.0 : 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Información del Reporte'),
              const SizedBox(height: 12),
              _buildReadOnlyField('Nombres', widget.reporte.nombres),
              _buildReadOnlyField('Apellidos', widget.reporte.apellidos),
              _buildReadOnlyField('Barrio', widget.reporte.barrio),
              _buildReadOnlyField('Comuna', widget.reporte.comuna),
              _buildReadOnlyField('Categoría', widget.reporte.categoria),
              _buildReadOnlyField('Descripción', widget.reporte.descripcion),
              _buildReadOnlyField('Dirección', widget.reporte.direccion),
              _buildReadOnlyField('Fecha Índice', widget.reporte.fecha),
              _buildReadOnlyField('Sección', widget.reporte.seccion),
              _buildReadOnlyField('Subcategoría', widget.reporte.subcategoria),
              _buildReadOnlyField('Sub-subcategoría', widget.reporte.subsubcategoria),
              _buildReadOnlyField('Zona', widget.reporte.zona),

              const SizedBox(height: 16),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 32,
                      vertical: isMobile ? 12 : 16,
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
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey[800],
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueGrey.withOpacity(0.2)),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(String label, String? value) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      items: ['Pendiente', 'En Proceso', 'Exitoso', 'Fallido'].map((String estado) {
        return DropdownMenuItem<String>(
          value: estado,
          child: Text(
            estado,
            style: const TextStyle(color: Colors.black87),
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
        fillColor: Colors.white,
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
