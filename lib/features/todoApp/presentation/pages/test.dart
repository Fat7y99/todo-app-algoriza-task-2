// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:test1/features/counter/presentation/cubit/cubit.dart';
// import 'package:test1/features/counter/presentation/cubit/states.dart';
//
// class TestPage extends StatefulWidget {
//   const TestPage({Key? key}) : super(key: key);
//
//   @override
//   State<TestPage> createState() => _TestPageState();
// }
//
// class _TestPageState extends State<TestPage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) {
//         return TaskCubit();
//       },
//       child: BlocConsumer<TaskCubit, TasksStates>(
//         listener: (context, state) {
//           debugPrint(state.toString());
//           if (state is InsertingTaskState) {
//             // TaskCubit.get(context).getTasks();
//             debugPrint('${BlocProvider.of<TaskCubit>(context).tasks}');
//           }
//         },
//         builder: (context, state) {
//           debugPrint('Build method executed in CounterWidget');
//           // debugPrint(state.toString());
//           // TaskCubit.get(context).getTasks();
//           if (state is AppInitialState) {
//             debugPrint('insertIntoDsatabase');
//
//             TaskCubit.get(context).getTasks();
//           }
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   FloatingActionButton(
//                     heroTag: 'dg',
//                     onPressed: () {
//                       // CounterCubit.get(context).decrement();
//                     },
//                     child: const Icon(
//                       FontAwesomeIcons.minus,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     '${TaskCubit.get(context).tasks.length}',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   FloatingActionButton(
//                     onPressed: () {
//                       TaskCubit.get(context).addTask();
//                       TaskCubit.get(context).getTasks();
//                     },
//                     child: const Icon(
//                       FontAwesomeIcons.plus,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
