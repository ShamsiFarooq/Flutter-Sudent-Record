import 'package:flutter/material.dart';
import 'package:student_record/screens/student_details.dart';
import '../../../db/model/data_model.dart';
import '../db/function/db_function.dart';

class ListStudent extends StatelessWidget {
  const ListStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        print(studentList.toString());
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: MemoryImage(data.image),
                ),
                title: Text(data.name),
                subtitle: Text(
                  data.age,
                ),
                trailing: IconButton(
                  onPressed: () {
                    if (data.id != null) {
                      deleteStudent(data.id!);
                    } else {
                      print('student data cannot be delete');
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                onTap: () {
                  studentDetailNavigator(context, data);
                });
          },
          separatorBuilder: (ctx, index) {
            return const Divider();
          },
          itemCount: studentList.length,
        );
      },
    );
  }

  studentDetailNavigator(BuildContext context, StudentModel data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx1) => StudentDetails(
            name: data.name,
            age: data.age,
            std: data.std,
            phn: data.phn,
            id: data.id!,
            image1: data.image),
      ),
    );
  }
}
