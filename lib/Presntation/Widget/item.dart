import 'package:flutter/material.dart';
import 'package:todo_app/busness_logic/Cubit/app_cubit.dart';

Widget buildTaskItem(Map model, BuildContext context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green,
            radius: 40.0,
            child: Text(
              '${model['date']}',
              style: const TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['title']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${model['time']}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
              onPressed: () {
                AppCubit.get(context).updateDate('done', model['id']);
              },
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () {
                AppCubit.get(context).updateDate('archive', model['id']);
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.black45,
              )),
        ],
      ),
    ),
    onDismissed: (direction)
    {
      AppCubit.get(context).deleteDate(model['id']);
    },
  );
}
