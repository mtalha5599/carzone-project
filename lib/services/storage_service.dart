import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;
  final _uuid = const Uuid();

  Future<String?> uploadCarImage(File image) async {
    try {
      final ref = _storage.ref().child('car_images/${_uuid.v4()}.jpg');
      await ref.putFile(image);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading mobile image: $e');
      return null;
    }
  }

  Future<String?> uploadWebCarImage(Uint8List data) async {
    try {
      final ref = _storage.ref().child('car_images/${_uuid.v4()}.jpg');
      await ref.putData(data);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading web image: $e');
      return null;
    }
  }
}
