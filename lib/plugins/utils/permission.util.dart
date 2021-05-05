import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  static Future<bool> storage() async {
    var storageStatus = await Permission.storage.status;
    if (!storageStatus.isGranted) {
      storageStatus = await Permission.storage.request();
    }
    return storageStatus.isGranted;
  }
}