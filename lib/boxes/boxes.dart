import 'package:hive/hive.dart';

import '../models/task_model.dart';

class Boxes {
  static Box<TaskModel> getData() => Hive.box<TaskModel>('mytask');
}
