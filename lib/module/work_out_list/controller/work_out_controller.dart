import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workout_tracker/utils/common_text.dart';

import '../../../data_base/local_database.dart';
import '../../../model/work_out_model.dart';

class WorkOutController extends GetxController with GetSingleTickerProviderStateMixin{
  TabController? tabController;
  final workOutTabs = [
    const Tab(text: 'All'),
    const Tab(
      text: 'By Date',
    ),
  ];
  List<Workout> allWorkouts = [];
  List<Workout> filteredWorkouts = [];
  final _dbService = DatabaseService();
  String? selectedDate;

  @override
  void onInit() {
    // implement onInit
    tabController = TabController(length: 2, vsync: this);
    tabController!.animateTo(0);
    fetchAllWorkouts();
    getCurrentDate();
    filterWorkoutsByDate();
    super.onInit();
  }
///to fetch current date
  String? getCurrentDate() {
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    debugPrint("selectedDate === $selectedDate");
    update();
   return selectedDate;

  }

  ///fetch workouts
  void fetchAllWorkouts() async {
    List<Workout> workoutList = await _dbService.getWorkouts();

      allWorkouts = workoutList;
      filteredWorkouts = allWorkouts;
   update();
  }



  ///workout list
buildWorkoutList(List<Workout> workouts) {

    return
      workouts.isEmpty?
          SizedBox(
              height: MediaQuery.of(Get.context!).size.height*0.4,
              child:const Center(child:  CommonText(text: "No Workout Done",))):
      ListView.builder(
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        Workout workout = workouts[index];
        return ListTile(
          title: CommonText(text:workout.name),
          subtitle: CommonText(text:' Date: ${workout.date}'),
          trailing:CommonText(text:'Value: ${workout.value} ')


        );
      },
    );
  }

  ///filter workout by date
  void filterWorkoutsByDate() async {
    List<Workout> workoutList = await _dbService.getWorkouts(date: selectedDate);
    filteredWorkouts = workoutList;
    update();
  }

}