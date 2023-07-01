import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_task/boxes/boxes.dart';
import 'package:my_task/controllers/home_controller.dart';
import 'package:my_task/models/task_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var homecontroller = Get.put(HomeController());
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Task App",
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              useSafeArea: true,
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Text("Add task"),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.toString().isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          controller: homecontroller.titleController,
                          decoration: const InputDecoration(
                            hintText: "Enter title",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      homecontroller.addTask();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text("Add")),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder<Box<TaskModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, box, child) {
            var data = box.values.toList()..cast<TaskModel>();
            if (box.length == 0) {
              return const Center(child: Text("No Data Found"));
            } else {
              return ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(data[index].title),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                value: homecontroller.checkVal.value,
                                onChanged: (bool? newval) {
                                  bool val = !newval!;
                                  homecontroller.updateCheckBox(val);
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                homecontroller.deleteTask(data[index]);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
