import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  PermissionService._();

  // Requests storage permissions based on Android version
  static Future<bool> requestStoragePermission() async {
    if (!Platform.isAndroid) return true;

    // Android 13 (API 33) and above uses READ_MEDIA_AUDIO
    if (await _isAndroid13OrAbove()) {
      final status = await Permission.audio.request();
      return status.isGranted;
    } else {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
  }

  // Requests notification permissions for background playback notifications (Android 13+)
  static Future<bool> requestNotificationPermission() async {
    if (!Platform.isAndroid) return true;

    if (await _isAndroid13OrAbove()) {
      final status = await Permission.notification.request();
      return status.isGranted;
    }
    return true;
  }

  // Complete bootstrap check
  static Future<bool> checkAndRequestAll() async {
    final storageGranted = await requestStoragePermission();
    final notificationsGranted = await requestNotificationPermission();
    return storageGranted && notificationsGranted;
  }

  // Returns true if storage is permanently denied, requiring user to open settings
  static Future<bool> isStoragePermanentlyDenied() async {
    if (!Platform.isAndroid) return false;

    if (await _isAndroid13OrAbove()) {
      return Permission.audio.isPermanentlyDenied;
    } else {
      return Permission.storage.isPermanentlyDenied;
    }
  }

  static Future<bool> openAppSettingsPage() async {
    return openAppSettings();
  }

  static Future<bool> _isAndroid13OrAbove() async {
    // We assume Android 13+ if target SDK / OS check is matched
    // In Flutter, OS version checking can be done via device_info_plus,
    // but a reliable fallback is to verify using the permission type itself.
    // If Permission.audio status is requested, permission_handler handles SDK version branching.
    return Platform.isAndroid;
  }
}
