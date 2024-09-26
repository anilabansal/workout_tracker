import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../utils/common_colors.dart';
import '../../utils/common_text.dart';
import 'controller/work_out_controller.dart';

class WorkOutView extends StatelessWidget {
  const WorkOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CommonText(text: 'Workout List'),
        backgroundColor: kPrimaryColor,
        toolbarHeight: 80,
      ),
      body: GetBuilder<WorkOutController>(
        init: WorkOutController(),
        builder: (workOutController) {
          return Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: TabBar(
                  controller: workOutController.tabController,
                  tabs: workOutController.workOutTabs,
                  indicatorColor: kPinkColor,
                  labelColor:kPinkColor,

                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: workOutController.tabController,
                  children: [
                    workOutController
                        .buildWorkoutList(workOutController.allWorkouts),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: CommonText(
                                    text:
                                        'Selected Date: ${workOutController.selectedDate}'),
                              ),
                              IconButton(
                                icon: const Icon(Icons.date_range),
                                onPressed: () async {
                                  DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime
                                        .now(), // Prevent future date selection
                                  );
                                  if (picked != null) {
                                    workOutController.selectedDate =
                                        DateFormat('yyyy-MM-dd').format(picked);
                                    workOutController.filterWorkoutsByDate();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: workOutController.buildWorkoutList(
                            workOutController.filteredWorkouts,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
