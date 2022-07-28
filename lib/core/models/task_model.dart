class TaskModel {
  String? title;
  String? date;
  String? startTime;
  String? endTime;
  String? remind;
  String? status;
  int? id;
  bool? isComleted;
  bool? isFavorite;
  TaskModel(
      {this.title,
      this.date,
      this.startTime,
      this.endTime,
      this.remind,
      this.status,
      this.id,
      this.isComleted,
      this.isFavorite});
  factory TaskModel.fromJson(Map<dynamic, dynamic> json) {
    return TaskModel(
      title: json['title'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      remind: json['remind'],
      status: json['status'],
      id: json['id'],
      isComleted: json['status'] == 'completed' ? true : false,
      isFavorite: json['status'] == 'Favorite' ? true : false,
    );
  }
  // convert list of map to list of model objects
  static List<TaskModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TaskModel.fromJson(json)).toList();
  }

  void printModel(TaskModel taskModel) {
    print("title: ${taskModel.title}");
    print("date: ${taskModel.date}");
    print("startTime: ${taskModel.startTime}");
    print("endTime: ${taskModel.endTime}");
    print("remind: ${taskModel.remind}");
    print("status: ${taskModel.status}");
    print("id: ${taskModel.id}");
  }
}
