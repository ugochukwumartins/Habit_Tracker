// ignore_for_file: prefer_const_constructors_in_immutables, unused_field

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/centered_svg_icon.dart';
import 'package:habit_tracker_flutter/ui/task/task_completion_ring.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class AnimatedTask extends StatefulWidget {
  AnimatedTask({Key? key, required this.iconName}) : super(key: key);
  final String iconName;
  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animatedController;
  late final Animation<double> _animationCurve;
  bool showCheckIcon = false;

  @override
  void initState() {
    super.initState();
    _animatedController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );
    _animatedController.addStatusListener(_checkStatusUpdate);
    _animationCurve =
        _animatedController.drive(CurveTween(curve: Curves.easeInOut));
    // _animatedController.forward();
    // _animatedController.reverse();
  }

  @override
  void dispose() {
    _animatedController.removeStatusListener(_checkStatusUpdate);
    _animatedController.dispose();
    super.dispose();
  }

  void _checkStatusUpdate(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (mounted) {
        setState(() => showCheckIcon = true);
      }

      Future.delayed(Duration(seconds: 1), () {
        if (mounted) {
          setState(() => showCheckIcon = false);
        }
      });
    }
  }

  void _tapedDown(TapDownDetails details) {
    if (_animatedController.status != AnimationStatus.completed) {
      _animatedController.forward();
    } else if (!showCheckIcon) {
      _animatedController.value = 0.0;
    }
  }

  void _tapUp(TapUpDetails details) {
    if (_animatedController.status != AnimationStatus.completed) {
      _animatedController.reverse();
    }
  }
   void _tapCancel() {
    if (_animatedController.status != AnimationStatus.completed) {
      _animatedController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _tapedDown,
      onTapUp: _tapUp,
      onTapCancel: _tapCancel,
      child: AnimatedBuilder(
          animation: _animationCurve,
          builder: (context, child) {
            final theme = AppTheme.of(context);
            final progress = _animationCurve.value;
            final hasCompleted = progress == 1.0;
            return Stack(
              children: [
                TaskCompletionRing(
                  progress: _animationCurve.value,
                ),
                Positioned.fill(
                    child: CenteredSvgIcon(
                        iconName: hasCompleted && showCheckIcon
                            ? AppAssets.check
                            : widget.iconName,
                        color: progress < 1.0
                            ? theme.taskIcon
                            : theme.accentNegative))
              ],
            );
          }),
    );
  }
}
