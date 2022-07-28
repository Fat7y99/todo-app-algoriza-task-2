import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/core/models/task_model.dart';

import '../../../tasks/presentation/cubit/cubit.dart';
import '../../../tasks/presentation/cubit/states.dart';

class TasksDetails extends StatefulWidget {
  List<TaskModel>? tasks;
  int index;
  List<String?>? actions = [];
  TasksDetails({required this.index, this.tasks, this.actions, Key? key})
      : super(key: key);

  @override
  State<TasksDetails> createState() => _TasksDetailsState();
}

class _TasksDetailsState extends State<TasksDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return TaskCubit();
        },
        child: BlocConsumer<TaskCubit, TasksStates>(listener: (context, state) {
          if (state is UpdatingTaskState ||
              state is DeletingTaskState ||
              state is AddingToFavouritesState) {
            debugPrint('updateTask');
            BlocProvider.of<TaskCubit>(context).getTasks();
          }
        }, builder: (context, state) {
          debugPrint('Build method executed in TasksDetails');
          if (state is AppInitialState || state is GettingTasksState) {
            // switch case for index
            switch (widget.index) {
              case 0:
                BlocProvider.of<TaskCubit>(context).getTasks();
                break;
              case 1:
                BlocProvider.of<TaskCubit>(context).getCompletedTasks();
                break;
              case 2:
                BlocProvider.of<TaskCubit>(context).getUncompletedTasks();
                break;
              default:
                BlocProvider.of<TaskCubit>(context).getFavoriteTasks();
                break;
            }
          }
          switch (widget.index) {
            case 0:
              widget.tasks = BlocProvider.of<TaskCubit>(context).tasks;
              break;
            case 1:
              widget.tasks = BlocProvider.of<TaskCubit>(context).completedTasks;
              break;
            case 2:
              widget.tasks =
                  BlocProvider.of<TaskCubit>(context).unCompletedTasks;
              break;
            default:
              widget.tasks = BlocProvider.of<TaskCubit>(context).favoriteTasks;
              break;
          }
          return Scaffold(
            body: ListView.builder(
              itemCount: widget.tasks!.length ?? 0,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(30),
                  height: 100,
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: widget.tasks![index].isComleted!
                              ? Colors.red.shade600
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: widget.tasks![index].isComleted!
                                ? Colors.red.shade600
                                : widget.tasks![index].isFavorite!
                                    ? Colors.yellow.shade600
                                    : Colors.blue,
                            width: 1,
                          ),
                        ),
                        child: widget.tasks![index].isComleted!
                            ? const Icon(
                                Icons.check, //set color to #ff5147
                                size: 10,
                                color: Colors.white,
                              )
                            : Container(),
                      ),
                      const SizedBox(
                        width: 30,
                        //red,orange,yellow,green
                      ),
                      Text(
                        "${widget.tasks![index].title}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      widget.actions != null
                          ? PopupMenuButton(
                              onSelected: (value) {
                                if (value == widget.actions![0]) {
                                  print("complete the task");
                                  BlocProvider.of<TaskCubit>(context)
                                      .updateTask('completed',
                                          widget.tasks![index].id!);
                                  print(widget.tasks![index].isComleted);
                                } else if (value == widget.actions![1]) {
                                  print('add to Favorite');
                                  BlocProvider.of<TaskCubit>(context)
                                      .updateTask(
                                          'Favorite', widget.tasks![index].id!);
                                } else if (value == widget.actions![2]) {
                                  print('delete the task');
                                  BlocProvider.of<TaskCubit>(context)
                                      .deleteTask(widget.tasks![index].id!);
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem(
                                    value: widget.actions![0],
                                    child: Text(widget.actions![0]!),
                                  ),
                                  PopupMenuItem(
                                    value: widget.actions![1],
                                    child: Text(widget.actions![1]!),
                                  ),
                                  PopupMenuItem(
                                    value: widget.actions![2],
                                    child: Text(widget.actions![2]!),
                                  ),
                                ];
                              },
                            )
                          : Container(),
                    ],
                  ),
                );
              },
            ),
          );
        }));
  }
}
