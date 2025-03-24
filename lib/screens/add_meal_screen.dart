import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../models/meal.dart';
import '../providers/meal_provider.dart';


class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  String? _imagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    Provider.of<MealProvider>(context, listen: false).addMeal(
      Meal(
        id: DateTime.now().toString(),
        name: _nameController.text,
        calories: int.parse(_caloriesController.text),
        time: DateTime.now(),
        imageUrl: _imagePath,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Meal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Meal Name'),
                validator: (value) =>
                value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: _caloriesController,
                decoration: const InputDecoration(labelText: 'Calories'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? 'Please enter calories' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Add Image'),
              ),
              if (_imagePath != null)
                Image.file(
                  File(_imagePath!),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              const Spacer(),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Save Meal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}