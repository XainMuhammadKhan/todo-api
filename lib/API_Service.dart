import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo/taskModel.dart';

Future<List<taskModel>> getTaskAPI() async {
  List<taskModel> taskData = [];
  var url = Uri.parse(
      "https://crudcrud.com/api/c9f4dd0103a047429393abecd6fa906c/tasks/");
  var response = await http.get(url);
  var responseBody = jsonDecode(response.body);

  for (var eachMap in responseBody) {
    taskData.add(taskModel.fromJson(eachMap));
  }
  return taskData;
}

Future postTaskAPI(String task, String priority, String Reward) async {
  var url = Uri.parse(
      "https://crudcrud.com/api/c9f4dd0103a047429393abecd6fa906c/tasks/");
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


Future UpdateTaskAPI(
    String id, String task, String priority, String Reward) async {
  var url = Uri.parse(
      "https://crudcrud.com/api/c9f4dd0103a047429393abecd6fa906c/tasks/$id");
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
    // Optionally print response error details
    print("Error details: ${response.body}");
  }
}

deleteTaskAPI(String id) async{
  var url = Uri.parse(
      "https://crudcrud.com/api/c9f4dd0103a047429393abecd6fa906c/tasks/$id");
  var response = await http.delete(url);
  if (response.statusCode == 200) {
    print("Task deleted successfully");
  } else {
    print("Failed to delete task");
    // Optionally print response error details
    print("Error details: ${response.body}");
  }
}