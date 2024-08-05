import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_management/presentation/widgets/background_wallpaper.dart';
import 'package:task_management/presentation/widgets/empty_list_widget.dart';
import '../../data/models/task_list_wrapper.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_bar.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  TaskListWrapper _progressTaskListWrapper = TaskListWrapper();
  bool _isGetCompletedTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    _getProgressTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWallpaper(
        child: RefreshIndicator(
          onRefresh: ()=>_getProgressTaskList(),
          child: Visibility(
            visible: _isGetCompletedTaskInProgress == false,
            replacement: const Center(child: CircularProgressIndicator(),),
            child: Visibility(
              visible: _progressTaskListWrapper.taskList?.isNotEmpty ??false,
              replacement: const EmptyListWidget(),
              child: ListView.builder(
                itemCount: _progressTaskListWrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(taskItem: _progressTaskListWrapper.taskList![index], refreshList: () { _getProgressTaskList(); },);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _getProgressTaskList() async {
    _isGetCompletedTaskInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.progressTaskList);
    if (response.isSuccess) {
      _progressTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _isGetCompletedTaskInProgress = false;
      setState(() {});
    } else {
      _isGetCompletedTaskInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMassage ?? 'Get progress task list has been field');
      }
    }
  }
}
