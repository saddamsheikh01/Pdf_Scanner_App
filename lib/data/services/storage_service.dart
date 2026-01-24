import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class StorageService {
  Future<void> openFile(File file) async {
    await OpenFile.open(file.path);
  }

  Future<File> saveToDownloads(File file, {String? fileName}) async {
    Directory? downloadsDir = await getDownloadsDirectory();
    downloadsDir ??= await getExternalStorageDirectory();

    if (downloadsDir == null) {
      throw FileSystemException('Downloads directory not available');
    }

    final safeDir = Directory('${downloadsDir.path}${Platform.pathSeparator}Download');
    final targetDir = await (await safeDir.exists() ? Future.value(safeDir) : safeDir.create(recursive: true));
    final targetName = fileName ?? file.uri.pathSegments.last;
    final targetPath = '${targetDir.path}${Platform.pathSeparator}$targetName';
    return file.copy(targetPath);
  }
}
