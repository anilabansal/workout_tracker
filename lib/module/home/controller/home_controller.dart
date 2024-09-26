import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../data_base/local_database.dart';
import '../../../main.dart';
import '../../../model/work_out_model.dart';
import '../../../utils/common_toast.dart';
import '../../bar_chart/chart_page.dart';
import '../../work_out_list/work_out_view.dart';

class HomeController extends GetxController{
  List<String> workouts = ['Push Ups', 'Squats', 'Running', 'Yoga'];
  String? selectedWorkout;
  int? _workoutValue;
  final _dbService = DatabaseService();
  TextEditingController workOutTextController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    fToast = FToast();
    fToast!.init(Get.context!);
  }
  @override
 void  dispose(){
    super.dispose();
    workOutTextController.dispose();

  }




  ///set a selected value

  setSelectedWorkOut(value){
    selectedWorkout = value;
    update();
  }



///mark as done
  Future<void> markAsDone() async {

    _workoutValue = int.tryParse(workOutTextController.text);


    if (selectedWorkout == null) {
      ShowToast.show(msg: 'Please select a workout.');
      return;
    }


    if (_workoutValue == null || _workoutValue! < 0 || _workoutValue! > 100) {
      ShowToast.show(msg: 'Please enter a workout value between 0 and 100.');
      return;
    }


    final workout = Workout(
      name: selectedWorkout!,
      value: _workoutValue!,
      date: DateTime.now().toIso8601String().split('T')[0],
      isDone: true,
    );
    await _dbService.addWorkout(workout);
    workOutTextController.clear();
    selectedWorkout = null;
    focusNode.unfocus();
    await Future.delayed(const Duration(seconds: 1));
    ShowToast.show(msg: 'Workout marked as done!');


    update();
  }




  Future<void>? navigateToWorkoutList() {
   return Get.to(()=> const WorkOutView());
  }

  Future<void>? navigateToChartPage() async {
    List<Workout> workoutData = await _dbService.getWorkouts();
   return Get.to(()=> ChartPage(workouts: workoutData));
  }

}