import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/busness_logic/Cubit/app_cubit.dart';
import 'package:todo_app/busness_logic/Cubit/app_state.dart';

import '../Widget/item.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).newTasks;
          return ConditionalBuilder(
            condition: tasks.length > 0,
            fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.menu,
                    size: 50,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'PlS add New Tasks',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.red[300]),
                    ),
                  )
                ],
              ),
            ),
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) {
                return buildTaskItem(
                    AppCubit.get(context).newTasks[index], context);
              },
              separatorBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                );
              },
              itemCount: AppCubit.get(context).newTasks.length,
            ),
          );
        });
  }
}
