import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/core/DB/db_helper.dart';
import 'package:test1/core/models/task_model.dart';
import 'package:test1/features/tasks/presentation/cubit/states.dart';

class TaskCubit extends Cubit<TasksStates> {
  TaskCubit() : super(AppInitialState());

  static TaskCubit get(context) => BlocProvider.of<TaskCubit>(context);

  List<TaskModel> tasks = [];
  List<TaskModel> unCompletedTasks = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> favoriteTasks = [];

  // String title, String date, String startTime,
  //     String endTime, String remind
  void addTask(String title, String date, String startTime, String endTime,
      String remind) async {
    debugPrint("inserted into DB");
    await DBHelper.instance
        .insertIntoDB(title, date, startTime, endTime, remind);
    emit(InsertingTaskState());
  }

  void getTasks() async {
    debugPrint("getDB");
    tasks =
        TaskModel.fromJsonList(await DBHelper.instance.getAllRecords('tasks'));
    emit(GettingTasksState());
  }

  //getCompletedRecords
  //getUncompletedRecords
  //getFavoriteRecords
  void getUncompletedTasks() async {
    unCompletedTasks = TaskModel.fromJsonList(
        await DBHelper.instance.getUncompletedRecords('tasks'));
    emit(GettingUncompletedTasksState());
  }

  void getCompletedTasks() async {
    completedTasks = TaskModel.fromJsonList(
        await DBHelper.instance.getCompletedRecords('tasks'));

    emit(GettingCompletedTasksState());
  }

  void getFavoriteTasks() async {
    favoriteTasks = TaskModel.fromJsonList(
        await DBHelper.instance.getFavoriteRecords('tasks'));
    emit(GettingFavoriteTasksState());
  }

  void deleteTask(int id) async {
    debugPrint("deleteDB");
    await DBHelper.instance.deleteRecord(id);
    emit(DeletingTaskState());
  }

  void updateTask(String status, int id) async {
    debugPrint("updateDB");
    await DBHelper.instance.updateRecord(status, id);
    emit(UpdatingTaskState());
  }
}
