import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo/taskModel.dart';

Future<List<taskModel>> getTaskAPI() async {
  List<taskModel> taskData = [];
  var url = Uri.parse(
      "https://crudcrud.com/api/a48ec559e4b0444096cb502929285ef8/tasks/");
  var response = await http.get(url);
  var responseBody = jsonDecode(response.body);

  for (var eachMap in responseBody) {
    taskData.add(taskModel.fromJson(eachMap));
  }
  return taskData;
}

Future<void> postTaskAPI(String task, String priority, String Reward) async {
  var url = Uri.parse(
      "https://crudcrud.com/api/a48ec559e4b0444096cb502929285ef8/tasks/");
  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"task": task, "priority": priority, "Reward": Reward}),
  );

  if (response.statusCode == 201) {
    print("Task added successfully");
  } else {
    print("Failed to add task");
  }
}

Future<void> UpdateTaskAPI(
    String task, String priority, String Reward, String id) async {
  var url = Uri.parse(
      "https://crudcrud.com/api/a48ec559e4b0444096cb502929285ef8/tasks/$id");
  var response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "task": task,
      "priority": priority,
      "Reward": Reward,
    }),
  );

  print("Update response status: ${response.statusCode}");
  print("Update response body: ${response.body}");

  if (response.statusCode == 200) {
    print("Task updated successfully");
  } else {
    print("Failed to update task");
  }
}
