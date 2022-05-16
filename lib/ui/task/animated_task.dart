// ignore_for_file: prefer_const_constructors_in_immutables, unused_field

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/task/task_completion_ring.dart';

class AnimatedTask extends StatefulWidget {
  AnimatedTask({Key? key}) : super(key: key);

  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animatedController;

  @override
  void initState() {
    super.initState();
    _animatedController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );

    _animatedController.forward();
    // _animatedController.reverse();
  }

  @override
  void dispose() {
    _animatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animatedController,
        builder: (context, child) {
          return TaskCompletionRing(
            progress: _animatedController.value,
          );
        });
  }
}
