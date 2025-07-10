import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

/// Wrapper class so we can work with either a [File] (mobile / desktop)
/// or raw [Uint8List] bytes (Flutter Web) plus the original filename.
class PickedFile {
  final File? file; // Non‑null on mobile / desktop
  final Uint8List? bytes; // Non‑null on web
  final String name; // Original filename

  PickedFile({this.file, this.bytes, required this.name});
}

class FilePickerHelper {
  /// Pick an image (jpg, png, etc.).
  static Future<PickedFile?> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true, // ensures bytes are loaded for web
    );
    if (result == null || result.files.isEmpty) return null;

    final f = result.files.first;
    return PickedFile(
      file: kIsWeb ? null : File(f.path!),
      bytes: f.bytes,
      name: f.name,
    );
  }

  /// Pick a video (mp4, mov, etc.).
  static Future<PickedFile?> pickVideo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      withData: true,
    );
    if (result == null || result.files.isEmpty) return null;

    final f = result.files.first;
    return PickedFile(
      file: kIsWeb ? null : File(f.path!),
      bytes: f.bytes,
      name: f.name,
    );
  }
}
