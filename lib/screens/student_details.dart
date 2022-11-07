import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../db/function/db_function.dart';
import '../db/model/data_model.dart';
import 'homescreen.dart';

class StudentDetails extends StatefulWidget {
  StudentDetails(
      {super.key,
      required this.name,
      required this.age,
      required this.std,
      required this.phn,
      required this.id,
      required this.image1});

  String name, phn, std, age;
  int id;
  Uint8List image1;

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _classController;
  late TextEditingController _phoneController;

  Uint8List? image;

  @override
  Widget build(BuildContext context) {
    _nameController = TextEditingController(text: widget.name);
    _ageController = TextEditingController(text: widget.age);
    _classController = TextEditingController(text: widget.std);
    _phoneController = TextEditingController(text: widget.phn);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Details'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: image != null
                ? Image.memory(
                    image!,
                    height: 200,
                    width: 200,
                  )
                : Image.memory(
                    widget.image1,
                    height: 200,
                    width: 200,
                  ),
          ),
          TextButton(
              onPressed: () {
                updateImage();
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectImage()));
              },
              child: const Text('Change Image')),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                //hintText: _nameController.text,
              ),
              validator: (value) {
                return value == null ||
                        value.isEmpty ||
                        !RegExp(r'^[a-zA-Z\s]{3,15}$').hasMatch(value)
                    ? 'Enter correct name'
                    : null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              controller: _ageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                //hintText: _ageController.text,
              ),
              validator: (value) {
                return value == null ||
                        value.isEmpty ||
                        !RegExp(r'^[0-9]{1,2}$').hasMatch(value)
                    ? 'Enter correct age'
                    : null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _classController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                //hintText: _classController.text,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // hintText: _phoneController.text,
              ),
              validator: (value) {
                return value == null ||
                        value.isEmpty ||
                        !RegExp(r'^[0-9]{10}$').hasMatch(value)
                    ? 'Enter valid phone number'
                    : null;
              },
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              dailogueBox(context);
              //replaceDetails(id);
              //print(_nameController.text);
            },
            icon: const Icon(Icons.add),
            label: const Text('Save'),
          ),
        ],
      ),
    );
  }

  onAddStudentButtonClicked() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _class = _classController.text.trim();
    final _phone = _phoneController.text.trim();

    if (_name.isEmpty || _age.isEmpty || _class.isEmpty || _phone.isEmpty) {
      return;
    } else {
      final _student = StudentModel(
          name: _name, age: _age, phn: _phone, std: _class, image: image!);
      addStudent(_student);
    }
  }

  replaceDetails(int id) {
    final _newname = _nameController.text.trim();
    final _newage = _ageController.text.trim();
    final _newclass = _classController.text.trim();
    final _newphone = _phoneController.text.trim();

    if (widget.name == _newname &&
        widget.age == _newage &&
        widget.std == _newclass &&
        widget.phn == _newphone &&
        widget.image1 == image) {
      return;
    } else {
      final _student = StudentModel(
          name: _newname,
          age: _newage,
          phn: _newphone,
          std: _newclass,
          id: id,
          image: image ?? widget.image1);
      updateStudent(_student, id);
    }
  }

  void updateStudent(StudentModel value, int id) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db1');
    // final _id = await studentDB.add(value);
    // value.id = _id;
    // final id = value.id;
    //print(id);
    studentDB.put(id, value);
    // studentListNotifier.value.add(value);
    // studentListNotifier.notifyListeners();
    getAllStudent();
  }

  void dailogueBox(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (ctx2) {
          return AlertDialog(
            title: const Text('Do you want to update'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text('CANCEL')),
              TextButton(
                  onPressed: () {
                    // deleteStudent(data.id!);
                    // Navigator.of(ctx).pop();
                    replaceDetails(widget.id);
                    Navigator.of(ctx2).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx2) => HomeScreen()),
                        (Route) => false);
                  },
                  child: const Text('OK')),
            ],
          );
        });
  }

  void updateImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    // final imagePermanent = await saveFilePermanently(image.path);
    final temp = await image.readAsBytes();
    setState(() {
      this.image = temp;
    });
  }
}


























// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class StudentDetails extends StatefulWidget {
//   StudentDetails(
//       {super.key,
//       required this.name,
//       required this.age,
//       required this.std,
//       required this.phn,
//       required this.id,
//       required this.image1});

//   String name, age, std, phn;
//   int id;
//   Uint8List image1;

//   @override
//   State<StudentDetails> createState() => _StudentDetailsState();
// }

// class _StudentDetailsState extends State<StudentDetails> {
//   late TextEditingController _nameController;
//   late TextEditingController _ageController;
//   late TextEditingController _classController;
//   late TextEditingController _phoneController;
//   Uint8List? image;

//   @override
//   Widget build(BuildContext context) {
//     _nameController = TextEditingController(text: widget.name);
//     _ageController = TextEditingController(text: widget.age);
//     _classController = TextEditingController(text: widget.std);
//     _phoneController = TextEditingController(text: widget.phn);
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: const Color.fromARGB(255, 233, 177, 94),
//           body: SafeArea(
//             child: ListView(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: image != null
//                       ? Image.memory(
//                           image!,
//                           height: 200,
//                           width: 200,
//                         )
//                       : Image.memory(
//                           widget.image1,
//                           height: 200,
//                           width: 200,
//                         ),
//                 ),
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 TextFormField(
//                   controller: _ageController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 TextFormField(
//                   controller: _classController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 TextFormField(
//                   controller: _phoneController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
