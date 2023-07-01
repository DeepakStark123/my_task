import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_task/boxes/boxes.dart';
import 'package:my_task/controllers/home_controller.dart';
import 'package:my_task/models/task_model.dart';
import 'package:my_task/views/details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var homecontroller = Get.put(HomeController());
    var formKey = GlobalKey<FormState>();

    updateTask(String title, String description, TaskModel task) {
      homecontroller.titleController.text = title;
      homecontroller.discriptionController.text = description;
      showDialog(
          useSafeArea: true,
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              actions: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
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
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        controller: homecontroller.discriptionController,
                        decoration: const InputDecoration(
                          hintText: "Enter discription",
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
                                  homecontroller.clearFields();
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
                                    homecontroller.updateTask(task);
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text("Update")),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
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
                            height: 10,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.toString().isEmpty) {
                                return "This field is required";
                              }
                              return null;
                            },
                            controller: homecontroller.discriptionController,
                            decoration: const InputDecoration(
                              hintText: "Enter discription",
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
                                      homecontroller.clearFields();
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
                  ],
                  // content:
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
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
                    return InkWell(
                      onTap: () {
                        Get.to(
                          DetailsScreen(
                            datetime: data[index].dateTime,
                            title: data[index].title,
                            discription: data[index].description,
                          ),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.all(5),
                        child: ListTile(
                          title: Text(
                            data[index].title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text((data[index].description.length > 35)
                              ? "${data[index].description.substring(0, 35)}....."
                              : data[index].description),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    homecontroller.deleteTask(data[index]);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                                IconButton(
                                  onPressed: () {
                                    updateTask(data[index].title,
                                        data[index].description, data[index]);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
