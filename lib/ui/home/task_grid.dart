// ignore_for_file: unused_local_variable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/task/task_with_name.dart';

class TaskGrid extends StatelessWidget {
  TaskGrid({Key? key, required this.tasks}) : super(key: key);
  final List<Task> tasks;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final crossAxisSpacing = constraints.maxWidth * 0.05;
      final taskWidth = (constraints.maxWidth - crossAxisSpacing) / 2.0;
      const aspectRatio = 0.82;
      final taskHeight = taskWidth / aspectRatio;
      // Use max(x, 0.1) to prevent layout error when keyword is visible in modal page
      final mainAxisSpacing = max((constraints.maxHeight - taskHeight * 3) / 2.0, 0.1);
      final tasksLength = tasks.length;
      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.8),
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskWithName(task: task);
        },
        itemCount: tasks.length,
      );
    });
  }
}
