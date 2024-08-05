import 'package:flutter/material.dart';
import 'package:task_management/data/models/task_list_wrapper.dart';
import 'package:task_management/presentation/widgets/background_wallpaper.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/profile_bar.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  TaskListWrapper _completedTaskListWrapper = TaskListWrapper();
  bool _isGetCompletedTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWallpaper(
        child: Visibility(
          visible: _isGetCompletedTaskInProgress == false,
          replacement: const Center(child: CircularProgressIndicator(),),
          child: Visibility(
            visible: _completedTaskListWrapper.taskList?.isNotEmpty ?? false,
            replacement: const EmptyListWidget(),
            child: ListView.builder(
              itemCount: _completedTaskListWrapper.taskList?.length ?? 0,
              itemBuilder: (context, index) {
                return TaskCard(taskItem: _completedTaskListWrapper.taskList![index], refreshList: () { _getCompletedTaskList(); },);
              },
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _getCompletedTaskList() async {
    _isGetCompletedTaskInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.completedTaskList);

    if (response.isSuccess) {
      _completedTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _isGetCompletedTaskInProgress = false;
      setState(() {});
    } else {
      _isGetCompletedTaskInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMassage ?? 'Get completed task list has been field');
      }
    }
  }
}

