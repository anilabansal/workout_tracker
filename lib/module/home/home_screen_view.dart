import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_text.dart';
import '../../utils/common_text_field.dart';
import 'controller/home_controller.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        title: const CommonText(text: 'Workout Tracker'),
        backgroundColor:kPrimaryColor ,
        toolbarHeight: 80,
      ) ,
      body:  GetBuilder<HomeController>(
          init: HomeController(),
          builder: (homeController) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const CommonText(
                  text: 'Select a workout, enter a value between 0 and 100, and mark it as done for today.',
                  softWrap: true,
                  fontWeight: FontWeight.bold,
                  color: kGreyColor,
                ),
                const SizedBox(height: 20,),
                DropdownButton<String>(
                  hint: const CommonText(text: 'Select Workout'),
                  value: homeController.selectedWorkout,
                  items: homeController.workouts.map((workout) {
                    return DropdownMenuItem(
                      value: workout,
                      child: Text(workout),
                    );
                  }).toList(),
                  onChanged: (value) {
                    homeController.setSelectedWorkOut(value);
                  },
                ),
                const SizedBox(height: 20,),
                CommonTextFormField(
                  focusNode: homeController.focusNode,
                  hintText: 'Workout Value (0-100)',
                  controller: homeController.workOutTextController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: homeController.markAsDone,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor
                    ),
                    child:  const CommonText(text: 'Mark as Done', color: Colors.black,)
                ),
                ElevatedButton(
                  onPressed:homeController.navigateToWorkoutList,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor
                  ),
                  child: const CommonText(text: 'View Workout List', color: Colors.black,),
                ),
                ElevatedButton(
                  onPressed: homeController.navigateToChartPage,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor
                  ),
                  child: const CommonText(text: 'View Workout Chart', color: Colors.black,),
                ),
              ],
            ),
          );
        }
      ),
    );

  }
}
