import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;

class WebFileDownloader {
  /// Inicia o download de um PDF no navegador.
  static void downloadPdf(Uint8List bytes, String fileName) {
    final blob = html.Blob([bytes], 'application/pdf');
    _downloadBlob(blob, fileName);
  }

  /// NOVO: Inicia o download de um CSV no navegador.
  static void downloadCsv(String csvText, String fileName) {
    // Dica Pro: Adicionar um BOM (Byte Order Mark) para UTF-8 garante que o
    // Excel abra o arquivo com a acentuação correta sem esforço.
    final csvWithBom = '\uFEFF$csvText';

    final blob = html.Blob([csvWithBom], 'text/csv;charset=utf-8;');
    _downloadBlob(blob, fileName);
  }

  /// Lógica de download genérica para qualquer Blob.
  static void _downloadBlob(html.Blob blob, String fileName) {
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
