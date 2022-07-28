import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:test1/core/util/widgets/text_utils.dart';

import '../../../../core/models/task_model.dart';
import '../../../tasks/presentation/cubit/cubit.dart';
import '../../../tasks/presentation/cubit/states.dart';

class SchedulePage extends StatefulWidget {
  List<TaskModel>? tasks;

  SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting();
  }

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
          widget.tasks = BlocProvider.of<TaskCubit>(context).tasks;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 15,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text('Schedule',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              toolbarHeight: 80,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade200,
                  ),
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.teal,
                    selectedTextColor: Colors.white,
                    dayTextStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    dateTextStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    monthTextStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    daysCount:
                        30, // Tasks scheduling should be during this month only
                    onDateChange: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextUtils(
                          textContent: "Sunday",
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      TextUtils(
                          textContent:
                              DateFormat.yMMMd().format(DateTime.now()),
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 0.65 * MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 25,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: widget.tasks![index].isComleted!
                                  ? Colors.red.shade600
                                  : widget.tasks![index].isFavorite!
                                      ? Colors.yellow.shade600
                                      : Colors.blue,
                              // border: ,
                            ),
                            padding: const EdgeInsets.all(30),
                            // height: 100,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "${widget.tasks![index].startTime}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${widget.tasks![index].title}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                                const Spacer(
                                  flex: 7,
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: Colors.white,
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
                              ],
                            ),
                          );
                        },
                        itemCount: widget.tasks?.length ?? 0),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
