import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/features/todoApp/presentation/pages/add_task.dart';
import 'package:test1/features/todoApp/presentation/pages/schedule_page.dart';
import 'package:test1/features/todoApp/presentation/pages/tasks_details.dart';

import '../../../tasks/presentation/cubit/cubit.dart';
import '../../../tasks/presentation/cubit/states.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({Key? key}) : super(key: key);

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  List<String>? actions = [
    'Complete the task',
    'Add to Favourites',
    'Delete the task'
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return TaskCubit();
        },
        child: BlocConsumer<TaskCubit, TasksStates>(listener: (context, state) {
          if (state is InsertingTaskState) {
            debugPrint('insertIntoDatabase');
            debugPrint('${BlocProvider.of<TaskCubit>(context).tasks}');
          }
        }, builder: (context, state) {
          debugPrint('Build method executed in onBoardPage');
          if (state is AppInitialState) {
            debugPrint('AppInitialState');
            BlocProvider.of<TaskCubit>(context).getTasks();
          }
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  actions: [
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      onSelected: (value) {
                        // if value =0 navigate to addtask page if 0 navigate to schedule page
                        if (value == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SchedulePage()));
                        } else if (value == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddTaskPage()));
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem(
                            value: 0,
                            child: Text('Show Schedule'),
                          ),
                          const PopupMenuItem(
                            value: 1,
                            child: Text('Add Task'),
                          ),
                        ];
                      },
                    ),
                  ],
                  bottom: TabBar(
                      isScrollable: true,
                      labelColor: Colors.grey,
                      indicatorColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.label,
                      controller: _tabController,
                      tabs: const [
                        Tab(
                          child: Text('All'),
                        ),
                        Tab(
                          child: Text('Completed'),
                        ),
                        Tab(
                          child: Text('Uncompleted'),
                        ),
                        Tab(
                          child: Text('Favorite'),
                        ),
                      ]),
                  elevation: 1,
                  toolbarHeight: 80,
                  backgroundColor: Colors.white,
                  title: const Text('Board',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold))),
              body: Column(
                children: [
                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade200,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        TasksDetails(
                          index: 0,
                          actions: actions,
                        ),
                        TasksDetails(index: 1),
                        TasksDetails(index: 2),
                        TasksDetails(index: 3),
                      ],
                      controller: _tabController,
                    ),
                  ),
                ],
              ));
        }));
  }
}
