import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String std;

  @HiveField(4)
  final String phn;
  @HiveField(5)
  Uint8List image;

  StudentModel(
      {required this.name,
      required this.age,
      required this.std,
      required this.phn,
      required this.image,
      this.id});
}
