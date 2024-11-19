import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:io' show Directory, File, Platform;
import 'package:path_provider/path_provider.dart';
import 'package:sivigila/Models/reporte.dart';

Future<void> exportReportesToExcel(List<Reporte> reportes) async {
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
  if (kIsWeb) {
    // Descargar el archivo en la web
    final blob = html.Blob([Uint8List.fromList(bytes)]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "reportes.xlsx")
      ..click();
    html.Url.revokeObjectUrl(url);
  } else {
    // Guardar el archivo en dispositivos móviles o de escritorio
    var status = await Permission.storage.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      print('Permiso de almacenamiento denegado');
      return;
    }

    Directory? directory = await getDownloadsDirectory();
    if (directory == null) {
      print('No se pudo acceder al directorio de almacenamiento externo');
      return;
    }
    String filePath = '${directory.path}/reportes.xlsx';
    // Escribir el archivo
    try {
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);
      print('Archivo Excel guardado en: $filePath');
    } catch (e) {
      print('Error al guardar el archivo Excel: $e');
    }
  }
}
