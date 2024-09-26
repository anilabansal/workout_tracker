import 'package:flutter/material.dart';
import 'package:workout_tracker/module/bar_chart/widget/bar_chart_painter.dart';
import 'package:workout_tracker/utils/common_text.dart';
import '../../model/work_out_model.dart';
import '../../utils/common_colors.dart';

class ChartPage extends StatefulWidget {
  final List<Workout> workouts;

  const ChartPage({super.key, required this.workouts});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();


    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );


    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Map<String, List<Workout>> groupedWorkouts = {};
    for (var workout in widget.workouts) {
      groupedWorkouts.putIfAbsent(workout.date, () => []).add(workout);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Workout Chart'),
        backgroundColor:kPrimaryColor ,
        toolbarHeight: 80,),
      body: SingleChildScrollView(
        child: groupedWorkouts.isEmpty?
            SizedBox(
              height: MediaQuery.sizeOf(context).height*0.7,
              child: const Center(
                child:  CommonText(
                  text: "No Data Found",
                ),
              ),
            ):
        Column(
          children: [
            for (var entry in groupedWorkouts.entries) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Workouts for ${entry.key}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: 400,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return CustomPaint(
                        size: Size((entry.value.length * 80).toDouble(), 400),
                        painter: BarChartPainter(entry.value, _animation.value),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ]
          ],
        ),
      ),
    );
  }
}