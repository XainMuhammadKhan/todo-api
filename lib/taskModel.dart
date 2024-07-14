class taskModel {
  String? task;
  String? priority;
  String? Reward;
  String? sId;

  taskModel({this.task, this.priority, this.Reward, String? id});

  taskModel.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    sId = json['sId'];
    priority = json['priority'];
    Reward = json['Reward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task'] = task;
    data['sId'] = sId;
    data['priority'] = priority;
    data['Reward'] = Reward;
    return data;
  }
}