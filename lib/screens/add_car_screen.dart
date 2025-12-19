import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/firebase_service.dart';
import '../models/car.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final picker = ImagePicker();
  File? _image;
  final _formKey = GlobalKey<FormState>();
  String? _brand, _model, _year, _price;

  Future<void> _pickImage(ImageSource source) async {
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_image != null) {
        final firebaseService = FirebaseService();
        final imageUrl = await firebaseService.uploadImage(_image!);
        final car = Car(
          brand: _brand!,
          model: _model!,
          year: _year!,
          price: _price!,
          imageUrl: imageUrl,
        );
        await firebaseService.addCar(car);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select an image.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Car')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_image != null)
                Image.file(_image!, height: 150, width: 150, fit: BoxFit.cover)
              else
                Text('No image selected'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                  IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Brand'),
                validator: (val) => val!.isEmpty ? 'Enter brand' : null,
                onSaved: (val) => _brand = val,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Model'),
                validator: (val) => val!.isEmpty ? 'Enter model' : null,
                onSaved: (val) => _model = val,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Year'),
                validator: (val) => val!.isEmpty ? 'Enter year' : null,
                onSaved: (val) => _year = val,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                validator: (val) => val!.isEmpty ? 'Enter price' : null,
                onSaved: (val) => _price = val,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Upload Car'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
