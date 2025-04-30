import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import '../models/material_log.dart';

class ExportService {
  // Export logs to PDF
  Future<File> exportToPdf(List<MaterialLog> logs, String title) async {
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(level: 0, child: pw.Text(title)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ['Material', 'Quantity', 'Cost', 'Date', 'Total'],
                data: logs.map((log) => [
                  log.materialName,
                  log.quantity.toString(),
                  log.cost.toString(),
                  log.date.toString(),
                  (log.quantity * log.cost).toStringAsFixed(2),
                ]).toList(),
              )
            ],
          );
        },
      ),
    );
    
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/material_logs.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
  
  // Export logs to CSV
  Future<File> exportToCsv(List<MaterialLog> logs) async {
    List<List<dynamic>> rows = [];
    
    // Add header row
    rows.add(['Material', 'Quantity', 'Cost', 'Date', 'Total Cost', 'Notes']);
    
    // Add data rows
    for (var log in logs) {
      rows.add([
        log.materialName,
        log.quantity,
        log.cost,
        log.date.toString(),
        log.quantity * log.cost,
        log.notes ?? '',
      ]);
    }
    
    String csv = const ListToCsvConverter().convert(rows);
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/material_logs.csv');
    await file.writeAsString(csv);
    return file;
  }
  
  // Share exported file
  Future<void> shareFile(File file) async {
    await Share.shareXFiles([XFile(file.path)]);
  }
}
