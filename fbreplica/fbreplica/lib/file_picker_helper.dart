import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class PickedFile {
  final File? file; // mobile / desktop
  final Uint8List? bytes; // web
  final String name;
  PickedFile({this.file, this.bytes, required this.name});
}

class FilePickerHelper {
  static Future<PickedFile?> pickImage() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (res == null || res.files.isEmpty) return null;
    final f = res.files.first;
    return PickedFile(
      file: kIsWeb ? null : File(f.path!),
      bytes: f.bytes,
      name: f.name,
    );
  }

  static Future<PickedFile?> pickVideo() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.video,
      withData: true,
    );
    if (res == null || res.files.isEmpty) return null;
    final f = res.files.first;
    return PickedFile(
      file: kIsWeb ? null : File(f.path!),
      bytes: f.bytes,
      name: f.name,
    );
  }
}
