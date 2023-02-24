import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/busness_logic/Cubit/app_cubit.dart';
import 'package:todo_app/busness_logic/Cubit/app_state.dart';

class Layout extends StatelessWidget {
  // int currentindex = 0;
  //
  // List<Widget> screen = [
  //   const NewTaskScreen(),
  //   const DoneTaskScreen(),
  //   const ArchivedTaskScreen(),
  // ];
  //
  // List<String> tittle = [
  //   'News Tasks',
  //   'Done Tasks',
  //   'Archived Tasks',
  // ];

  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) => {
          if (state is AppInsertDataBaseState) {Navigator.pop(context)}
        },
        builder: (BuildContext context, AppState state) {
          AppCubit appCubit = AppCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(AppCubit.get(context)
                  .tittle[AppCubit.get(context).currentindex]),
            ),
            body: AppCubit.get(context)
                .screen[AppCubit.get(context).currentindex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.grey[300],
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 720,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'BottomSheet',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    style: const TextStyle(fontSize: 25),
                                    decoration: const InputDecoration(
                                      label: Text('title'),
                                      labelStyle: TextStyle(
                                          fontSize: 30, color: Colors.black),
                                      prefixIcon: Icon(
                                        Icons.title,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                    controller: titleController,
                                    validator: (value) {
                                      return value!.isEmpty
                                          ? 'title is required'
                                          : null;
                                    },
                                    keyboardType: TextInputType.text,
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    style: const TextStyle(fontSize: 25),
                                    decoration: const InputDecoration(
                                      label: Text('Task Time'),
                                      labelStyle: TextStyle(
                                          fontSize: 30, color: Colors.black),
                                      prefixIcon: Icon(
                                        Icons.access_time,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                    controller: timeController,
                                    validator: (value) {
                                      return value!.isEmpty
                                          ? 'time is required'
                                          : null;
                                    },
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                        print(value!.format(context));
                                      });
                                    },
                                    keyboardType: TextInputType.datetime,
                                  ),
                                  const SizedBox(height: 15),
                                  TextFormField(
                                    style: const TextStyle(fontSize: 25),
                                    decoration: const InputDecoration(
                                      label: Text('Task Date'),
                                      labelStyle: TextStyle(
                                          fontSize: 30, color: Colors.black),
                                      prefixIcon: Icon(
                                        Icons.calendar_month,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                    controller: dateController,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2024-07-06'),
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    validator: (value) {
                                      return value!.isEmpty
                                          ? 'title is required'
                                          : null;
                                    },
                                    keyboardType: TextInputType.datetime,
                                  ),
                                  const SizedBox(height: 5),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.grey[500])),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          appCubit.insertIntoDatabase(
                                            titleController.text,
                                            timeController.text,
                                            dateController.text,
                                          );

                                          // AppCubit.get(context)
                                          //     .insertIntoDatabase(
                                          //   titleController.text,
                                          //   timeController.text,
                                          //   dateController.text,
                                          // );
                                        }
                                      },
                                      child: const Text(
                                        'apply',
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.black),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: const Icon(
                Icons.add,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: AppCubit.get(context).currentindex,
              onTap: (index) {
                AppCubit.get(context).changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.cloud_done), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archived'),
              ],
            ),
          );
        },
      ),
    );
  }
}
