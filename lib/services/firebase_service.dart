import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/car.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File imageFile) async {
    final ref = _storage.ref().child('car_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }

  Future<void> addCar(Car car) async {
    await _db.collection('cars').add(car.toMap());
  }

  Stream<List<Car>> getCars() {
    return _db.collection('cars').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Car.fromMap(doc.data())).toList();
    });
  }
}
