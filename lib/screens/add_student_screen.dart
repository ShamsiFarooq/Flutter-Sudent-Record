import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../db/function/db_function.dart';
import '../db/model/data_model.dart';

class AddStudentScreen extends StatefulWidget {
  AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _stdController = TextEditingController();

  final _phController = TextEditingController();

  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 177, 216, 248),
        body: SafeArea(
          child: ListView(
            children: [
              image != null
                  ? Image.memory(
                      image!,
                      height: 200,
                      width: 250,
                    )
                  : ElevatedButton(
                      onPressed: () {
                        pickImage();
                      },
                      child: Text('Select Image'),
                    ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Age',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _stdController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Class',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: _phController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter contact number',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    onAddStudentButtonClicked(context);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Student')),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(BuildContext context) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _std = _stdController.text.trim();
    final _phn = _phController.text.trim();
    //Uint8List? image;

    if (_name.isEmpty || _age.isEmpty || _std.isEmpty || _phn.isEmpty) {
      return;
    }
    //print('$_name  : $_age');
    final _student = StudentModel(
      name: _name,
      age: _age,
      std: _std,
      phn: _phn,
      image: image!,
    );
    addStudent(_student);
    Navigator.pop(context);
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final image = await _picker.pickImage(source: ImageSource.gallery);

    final temp = await image!.readAsBytes();
    setState(() {
      this.image = temp;
    });
  }
}
