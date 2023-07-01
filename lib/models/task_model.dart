// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'task_model.g.dart';

// @HiveType(typeId: 0)
// class TaskModel extends HiveObject {
//   @HiveField(0)
//   String title;
//   TaskModel({
//     required this.title,
//   });
// }

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  DateTime dateTime;
  TaskModel({
    required this.title,
    required this.description,
    required this.dateTime,
  });
}
