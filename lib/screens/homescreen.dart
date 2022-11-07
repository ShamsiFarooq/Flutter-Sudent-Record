import 'package:flutter/material.dart';
import 'package:student_record/screens/add_student_screen.dart';
import 'package:student_record/screens/list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[900],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  addStudentScreen(context);
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Student'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  listStudent(context);
                },
                icon: const Icon(Icons.list),
                label: const Text('Student list'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addStudentScreen(BuildContext ctx) {
    Navigator.of(ctx)
        .push(MaterialPageRoute(builder: (ctx1) => AddStudentScreen()));
  }

  void listStudent(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (ctx1) => ListScreen()));
  }
}
