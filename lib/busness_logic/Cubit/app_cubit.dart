import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/busness_logic/Cubit/app_state.dart';

import '../../Presntation/Screens/archived_tasks_screen.dart';
import '../../Presntation/Screens/done_tasks_screen.dart';
import '../../Presntation/Screens/new_task_screen.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> arciveTasks = [];

  List<Widget> screen = [
    const NewTaskScreen(),
    const DoneTaskScreen(),
    const ArchivedTaskScreen(),
  ];

  List<String> tittle = [
    'News Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    currentindex = index;
    emit(AppChangeBottomNavlState());
  }

  Database? database;

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('database crated');
      database
          .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('Table Created');
      }).catchError((error) {
        print('error when create table ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDataBase(database);
      print('database open');
    }).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  void updateDate(String status, int id) {
    database?.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      print(value);
      emit(AppUpdateDataBaseState());
      getDataFromDataBase(database);
    });
  }

  void deleteDate(int id) {
    database?.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      print(value);
      emit(AppDeleteDataBaseState());
      getDataFromDataBase(database);
    });
  }

  void insertIntoDatabase(String title, String time, String date) {
    database?.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks (title, date ,time ,status) VALUES ("$title","$time","$date","new") ')
          .then((value) {
        print(' $value insert Succesed');
        emit(AppInsertDataBaseState());

        getDataFromDataBase(database);
      }).catchError((error) {
        print('error when insert in table ${error.toString()}');
      });
    });
  }

  void getDataFromDataBase(database) {
    newTasks = [];
    doneTasks = [];
    arciveTasks = [];
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else if (element['status'] == 'archive') {
          arciveTasks.add(element);
        }
      });
      emit(AppGetDataBaseState());
    });
  }
}
