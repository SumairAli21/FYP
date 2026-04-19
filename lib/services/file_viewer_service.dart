import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileViewerService {
  
  // File type check karne ke liye static helpers
  static bool isPdf(String? url) {
    if (url == null) return false;
    return url.toLowerCase().contains('.pdf');
  }

  static bool isWord(String? url) {
    if (url == null) return false;
    final u = url.toLowerCase();
    return u.contains('.doc') || u.contains('.docx');
  }

  static bool isPpt(String? url) {
    if (url == null) return false;
    final u = url.toLowerCase();
    return u.contains('.ppt') || u.contains('.pptx');
  }

  static bool isSupported(String? url) {
    return isPdf(url) || isWord(url) || isPpt(url);
  }

  // Main download + open function
  Future<void> downloadAndOpen({
    required String fileUrl,
    required String fileName,
    required Function(double) onProgress,
    required Function(String) onError,
    required Function() onSuccess,
  }) async {
    try {
      final dir = await getTemporaryDirectory();
      final savePath = '${dir.path}/$fileName';
      final file = File(savePath);

      // Agar already downloaded hai toh skip karo
      if (await file.exists()) {
        await _openFile(savePath, onError);
        onSuccess();
        return;
      }

      final dio = Dio();
      await dio.download(
        fileUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            onProgress(received / total);
          }
        },
      );

      await _openFile(savePath, onError);
      onSuccess();

    } catch (e) {
      onError('Download failed: $e');
    }
  }

  Future<void> _openFile(String path, Function(String) onError) async {
    final result = await OpenFile.open(path);
    if (result.type != ResultType.done) {
      onError('Could not open file: ${result.message}');
    }
  }
}