import 'package:flutter/material.dart';

import 'package:todo/API_Service.dart';
import 'package:todo/taskModel.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  TextEditingController taskTextController = TextEditingController();
  TextEditingController priorityTextController = TextEditingController();
  TextEditingController rewardTextController = TextEditingController();
  List<taskModel> tasks = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    taskTextController.dispose();
    priorityTextController.dispose();
    rewardTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.redAccent[700],
          title: const Text(
            'Todo',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Add New Task"),
                contentPadding: const EdgeInsets.all(30),
                backgroundColor: Colors.white,
                content: Container(
                  width: 300,
                  height: 400,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextField(
                          controller: taskTextController,
                          decoration: InputDecoration(
                            hintText: "Add Task",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: priorityTextController,
                          decoration: InputDecoration(
                            hintText: "Add Priority",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: rewardTextController,
                          decoration: InputDecoration(
                            hintText: "Add Reward",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  tasks.add(taskModel(
                                      task: taskTextController.text,
                                      priority: priorityTextController.text,
                                      Reward: rewardTextController.text));
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text("Add"),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {});
                                Navigator.of(context).pop();
                                taskTextController.clear();
                                priorityTextController.clear();
                                rewardTextController.clear();
                              },
                              child: const Text("Cancel"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: tasks.isEmpty
            ? const Center(child: Text('No tasks added yet.'))
            : FutureBuilder(
                future: getTaskAPI(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No tasks available.'));
                  } else {
                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          tileColor: Colors.grey[350],
                          title: Text(
                            tasks[index].task ?? "No Task Name",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tasks[index].priority ?? "No Priority Set!"),
                              Text(tasks[index].Reward ?? "No Reward Set!"),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  taskTextController.text =
                                      tasks[index].task ?? "";
                                  priorityTextController.text =
                                      tasks[index].priority ?? "";
                                  rewardTextController.text =
                                      tasks[index].Reward ?? "";
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Edit Task"),
                                      contentPadding: const EdgeInsets.all(30),
                                      backgroundColor: Colors.white,
                                      content: Container(
                                        width: 300,
                                        height: 400,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextField(
                                                controller: taskTextController,
                                                decoration: InputDecoration(
                                                  hintText: "Edit Task",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              TextField(
                                                controller:
                                                    priorityTextController,
                                                decoration: InputDecoration(
                                                  hintText: "Edit Priority",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              TextField(
                                                controller:
                                                    rewardTextController,
                                                decoration: InputDecoration(
                                                  hintText: "Edit Reward",
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      await UpdateTaskAPI(
                                                          snapshot.data?[index].sId ??
                                                              "",
                                                          taskTextController
                                                              .text,
                                                          priorityTextController
                                                              .text,
                                                          rewardTextController
                                                              .text);
                                                      setState(() {
                                                        tasks[index] = taskModel(
                                                            id: snapshot
                                                                .data?[index]
                                                                .sId,
                                                            task:
                                                                taskTextController
                                                                    .text,
                                                            priority:
                                                                priorityTextController
                                                                    .text,
                                                            Reward:
                                                                rewardTextController
                                                                    .text);
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("Save"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      taskTextController
                                                          .clear();
                                                      priorityTextController
                                                          .clear();
                                                      rewardTextController
                                                          .clear();
                                                    },
                                                    child: const Text("Cancel"),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  // await deleteTaskAPI(tasks[index].sId!);
                                  // await reloadTasks();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }));
  }
}
