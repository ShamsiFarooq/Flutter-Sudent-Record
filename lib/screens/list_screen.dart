import 'package:flutter/material.dart';
import 'package:student_record/screens/list_student_screen.dart';

import '../db/function/db_function.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getAllStudent();
    });
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 116, 235, 120),
      body: SafeArea(
          child: Column(
        children: const [
          Expanded(child: ListStudent()),
        ],
      )),
    );
  }
}
