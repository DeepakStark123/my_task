import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_task/boxes/boxes.dart';

import '../models/task_model.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  var checkVal = false.obs;
  TextEditingController titleController = TextEditingController();

  updateCheckBox(bool val) {
    checkVal.value = val;
    update();
  }

  addTask() {
    var task = TaskModel(title: titleController.text);
    final box = Boxes.getData();
    box.add(task);
    task.save();
    Get.snackbar("Status", "Task Added", duration: const Duration(seconds: 1));
    titleController.clear();
  }

  deleteTask(TaskModel task) {
    task.delete();
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }
}
