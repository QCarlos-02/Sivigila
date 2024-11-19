// ignore: file_names
import 'package:excel/excel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Directory, File;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:sivigila/Models/reporte.dart';

Future<void> exportReportesToExcel(
    BuildContext context, List<Reporte> reportes) async {
  // Crear un nuevo archivo de Excel
  var excel = Excel.createExcel();

  // Crear una hoja de trabajo
  Sheet sheetObject = excel['Reportes'];
  excel.delete('Sheet1');

  // Agregar encabezados
  sheetObject.appendRow([
    TextCellValue('Sección'),
    TextCellValue('Categoría'),
    TextCellValue('Subcategoría'),
    TextCellValue('Subsubcategoría'),
    TextCellValue('Nombres'),
    TextCellValue('Apellidos'),
    TextCellValue('Fecha'),
    TextCellValue('Comuna'),
    TextCellValue('Barrio'),
    TextCellValue('Dirección'),
    TextCellValue('Zona'),
    TextCellValue('Descripción'),
    TextCellValue('Estado'),
    TextCellValue('Comentarios Referente'),
    TextCellValue('Tiene Comentario'),
    TextCellValue('Observaciones')
  ]);

  // Agregar datos de los reportes
  for (var reporte in reportes) {
    sheetObject.appendRow([
      TextCellValue(reporte.seccion),
      TextCellValue(reporte.categoria),
      TextCellValue(reporte.subcategoria),
      TextCellValue(reporte.subsubcategoria),
      TextCellValue(reporte.nombres),
      TextCellValue(reporte.apellidos),
      TextCellValue(reporte.fecha),
      TextCellValue(reporte.comuna),
      TextCellValue(reporte.barrio),
      TextCellValue(reporte.direccion),
      TextCellValue(reporte.zona),
      TextCellValue(reporte.descripcion),
      TextCellValue(reporte.estado),
      TextCellValue(reporte.comentRef?.join(', ') ?? ''),
      TextCellValue(reporte.tieneComentario ? 'Sí' : 'No'),
      TextCellValue(reporte.observaciones)
    ]);
  }

  // Convertir a bytes
  var bytes = excel.encode();
  if (bytes == null) {
    print('Error al codificar el archivo Excel');
    return;
  }

  // Solicitar permisos de almacenamiento
  var status = await Permission.storage.request();
  if (!status.isGranted) {
    print('Permiso de almacenamiento denegado');
    return;
  }

  // Guardar el archivo en la carpeta de descargas pública del dispositivo
  Directory? directory = await getApplicationDocumentsDirectory();
  String filePath = '${directory?.path}/reportes.xlsx';

  // Verificar si el archivo ya existe
  if (File(filePath).existsSync()) {
    // Si el archivo existe, sobrescribirlo
    File(filePath).deleteSync(); // Eliminar el archivo existente
  }

  // Escribir el archivo
  try {
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes);
    print('Archivo Excel guardado en: $filePath');

    // Verificar si el widget aún está montado antes de mostrar el SnackBar
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Reporte guardado con éxito en: $filePath'),
          duration: Duration(seconds: 8),
        ),
      );
    }
    //Navigator.pop(context);
  } catch (e) {
    print('Error al guardar el archivo Excel: $e');
  }
}
