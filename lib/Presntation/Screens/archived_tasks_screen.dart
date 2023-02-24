import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../busness_logic/Cubit/app_cubit.dart';
import '../../busness_logic/Cubit/app_state.dart';
import '../Widget/item.dart';

class ArchivedTaskScreen extends StatelessWidget {
  const ArchivedTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
            itemBuilder: (context, index) {
              return buildTaskItem(
                  AppCubit.get(context).arciveTasks[index], context);
            },
            separatorBuilder: (context, index) {
              return Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              );
            },
            itemCount: AppCubit.get(context).arciveTasks.length,
          );
        });
  }
}
