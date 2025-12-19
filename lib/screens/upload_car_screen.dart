import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadCarScreen extends StatefulWidget {
  const UploadCarScreen({super.key});

  @override
  State<UploadCarScreen> createState() => _UploadCarScreenState();
}

class _UploadCarScreenState extends State<UploadCarScreen> {
  final _formKey = GlobalKey<FormState>();
  final _makeController = TextEditingController();
  final _modelController = TextEditingController();
  final _priceController = TextEditingController();

  File? _imageFile;
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() => _imageFile = File(pickedImage.path));
    }
  }

  Future<void> _uploadCar() async {
    if (!_formKey.currentState!.validate() || _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all fields & select an image")),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      // Upload image to Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('car_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      await ref.putFile(_imageFile!);
      final imageUrl = await ref.getDownloadURL();

      // Save car data to Firestore
      await FirebaseFirestore.instance.collection('cars').add({
        'make': _makeController.text.trim(),
        'model': _modelController.text.trim(),
        'price': _priceController.text.trim(),
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Car uploaded successfully!")),
      );

      _makeController.clear();
      _modelController.clear();
      _priceController.clear();
      setState(() => _imageFile = null);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Upload failed: $e")),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Car")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                    image: _imageFile != null
                        ? DecorationImage(image: FileImage(_imageFile!), fit: BoxFit.cover)
                        : null,
                  ),
                  child: _imageFile == null
                      ? const Center(child: Icon(Icons.camera_alt, size: 60, color: Colors.deepPurple))
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _makeController,
                decoration: const InputDecoration(labelText: "Car Make (e.g., Toyota)"),
                validator: (v) => v!.isEmpty ? 'Enter car make' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(labelText: "Model (e.g., Corolla)"),
                validator: (v) => v!.isEmpty ? 'Enter car model' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: "Price (e.g., 4500000)"),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Enter price' : null,
              ),
              const SizedBox(height: 25),
              _isUploading
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      icon: const Icon(Icons.cloud_upload),
                      label: const Text("Upload Car"),
                      onPressed: _uploadCar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
