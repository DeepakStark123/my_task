import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_task/boxes/boxes.dart';

import '../models/task_model.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  var checkVal = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();

  updateCheckBox(bool val) {
    checkVal = val;
    update();
  }

  addTask() {
    var task = TaskModel(
      title: titleController.text,
      description: discriptionController.text,
      dateTime: DateTime.now(),
    );
    final box = Boxes.getData();
    box.add(task);
    task.save();
    clearFields();
  }

  updateTask(TaskModel task) {
    task.title = titleController.text;
    task.description = discriptionController.text;
    task.dateTime = DateTime.now();
    task.save();
    clearFields();
  }

  deleteTask(TaskModel task) {
    task.delete();
  }

  clearFields() {
    titleController.clear();
    discriptionController.clear();
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }
}
