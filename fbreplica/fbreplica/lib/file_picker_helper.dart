// file_picker_helper.dart
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class PickedFile {
  final File? file; // For mobile/desktop
  final Uint8List? bytes; // For web
  final String? name; // Filename or path

  PickedFile({this.file, this.bytes, this.name});
}

class FilePickerHelper {
  /// Pick an image file (jpg, png, etc.)
  static Future<PickedFile?> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      final platformFile = result.files.first;
      if (kIsWeb) {
        return PickedFile(bytes: platformFile.bytes, name: platformFile.name);
      } else {
        return PickedFile(
          file: File(platformFile.path!),
          name: platformFile.name,
        );
      }
    }
    return null; // User cancelled
  }

  /// Pick a video file (mp4, mov, etc.)
  static Future<PickedFile?> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null && result.files.isNotEmpty) {
      final platformFile = result.files.first;
      if (kIsWeb) {
        return PickedFile(bytes: platformFile.bytes, name: platformFile.name);
      } else {
        return PickedFile(
          file: File(platformFile.path!),
          name: platformFile.name,
        );
      }
    }
    return null; // User cancelled
  }
}
