import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:test1/core/DB/db_helper.dart';
import 'package:test1/core/util/widgets/my_drop_down.dart';

import '../../../../core/util/widgets/text_form_field.dart';
import '../../../../core/util/widgets/text_utils.dart';
import '../../../tasks/presentation/cubit/cubit.dart';
import '../../../tasks/presentation/cubit/states.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  List<String?> remindItems = [
    "1 day early",
    "1 hour before",
    "30 min before",
    "10 min before",
  ];
  String? remindValue = "10 min before";
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

  TimeOfDay _endTime =
      TimeOfDay(hour: DateTime.now().hour + 1, minute: DateTime.now().minute);

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
            BlocProvider.of<TaskCubit>(context).getTasks();
            debugPrint('${BlocProvider.of<TaskCubit>(context).tasks}');
          }
        }, builder: (context, state) {
          debugPrint('Build method executed in CounterWidget');

          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
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
              title: const Text('Add Task',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              toolbarHeight: 80,
              elevation: 1,
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: TextUtils(
                        textContent: "Title",
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  MyTextFormField(
                    hintText: 'Design team meeting',
                    labelText: "",
                    keyboardType: TextInputType.text,
                    controller: _titleController,
                    obscureText: false,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: TextUtils(
                        textContent: "Date",
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  MyTextFormField(
                    readOnly: true,
                    hintText: DateFormat('yyyy-MM-dd').format(_selectedDate),
                    labelText: "",
                    keyboardType: TextInputType.text,
                    controller: _dateController,
                    obscureText: false,
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((value) {
                          setState(() {
                            _selectedDate = value!;
                            print(_selectedDate);
                          });
                        });
                      },
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: TextUtils(
                            textContent: "Start time",
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: TextUtils(
                            textContent: "End time",
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: MyTextFormField(
                            readOnly: true,
                            hintText: _startTime.format(context),
                            labelText: "",
                            keyboardType: TextInputType.text,
                            controller: _dateController,
                            obscureText: false,
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.access_time,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(
                                      hour: _startTime.hour,
                                      minute: _startTime.minute),
                                  initialEntryMode: TimePickerEntryMode.input,
                                ).then((value) {
                                  setState(() {
                                    _startTime = value!;
                                    print("startTime:" + _startTime.toString());
                                  });
                                });
                              },
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Expanded(
                          child: MyTextFormField(
                            readOnly: true,
                            hintText: _endTime.format(context),
                            labelText: "",
                            keyboardType: TextInputType.text,
                            controller: _dateController,
                            obscureText: false,
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.access_time,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                showTimePicker(
                                  initialTime: TimeOfDay(
                                      hour: _endTime.hour,
                                      minute: _endTime.minute),
                                  context: context,
                                  initialEntryMode: TimePickerEntryMode.input,
                                ).then((value) {
                                  setState(() {
                                    _endTime = value!;
                                    print("endTime:" + _endTime.toString());
                                  });
                                });
                              },
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: TextUtils(
                        textContent: "Remind",
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  MyDropDown(items: remindItems, dropDownValue: remindValue),
                  const SizedBox(
                    height: 150,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.teal,
                    ),
                    child: MaterialButton(
                      onPressed: () async {
                        // DBHelper().initDB();
                        // var x = await DBHelper().createTable();
                        print(
                            "number of records:${await DBHelper.instance.getNumberOfRecords('tasks')}");

                        String _startTimeString =
                            int.parse(_startTime.hour.toString()) > 12
                                ? (int.parse(_startTime.hour.toString()) - 12)
                                    .toString()
                                : _startTime.hour.toString();

                        String _endTimeString =
                            int.parse(_endTime.hour.toString()) > 12
                                ? (int.parse(_endTime.hour.toString()) - 12)
                                    .toString()
                                : _endTime.hour.toString();

                        String sTimeMin =
                            int.parse(_startTime.minute.toString()) >= 10
                                ? _startTime.minute.toString()
                                : '0${_startTime.minute.toString()}';

                        String sTimeHour = int.parse(_startTimeString) >= 10
                            ? _startTimeString
                            : '0$_startTimeString';

                        String eTimeMin =
                            int.parse(_endTime.minute.toString()) >= 10
                                ? _endTime.minute.toString()
                                : '0${_endTime.minute.toString()}';
                        String eTimeHour = int.parse(_endTimeString) >= 10
                            ? _endTimeString
                            : '0$_endTimeString';

                        String aM =
                            _startTimeString == _startTime.hour.toString()
                                ? 'AM'
                                : 'PM';
                        TaskCubit.get(context).addTask(
                            _titleController.text.trim(),
                            _dateController.text.trim(),
                            '$sTimeHour:$sTimeMin  $aM',
                            '$eTimeHour:$eTimeMin',
                            remindValue!);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Create a Task",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
