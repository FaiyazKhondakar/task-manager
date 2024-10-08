import 'dart:math';
import 'package:flutter/material.dart';
import 'package:task_management/presentation/widgets/background_wallpaper.dart';
import 'package:task_management/presentation/widgets/empty_list_widget.dart';
import '../../data/models/task_list_wrapper.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_bar.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';


class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  TaskListWrapper _cancelledTaskListWrapper = TaskListWrapper();
  bool _isCancelledTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWallpaper(
        child: RefreshIndicator(
          onRefresh: () =>_getCancelledTaskList(),
          child: Visibility(
            visible: _isCancelledTaskInProgress == false,
            replacement: const Center(child: CircularProgressIndicator(),),
            child: Visibility(
              visible: _cancelledTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: const EmptyListWidget(),
              child: ListView.builder(
                itemCount: _cancelledTaskListWrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(taskItem: _cancelledTaskListWrapper.taskList![index], refreshList: () =>_getCancelledTaskList(),);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _getCancelledTaskList() async {
    _isCancelledTaskInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.cancelledTaskList);
    
    if (response.isSuccess) {
      _cancelledTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _isCancelledTaskInProgress = false;
      setState(() {});
    } else {
      _isCancelledTaskInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMassage ?? 'Get canceled task list has been field');
      }
    }
  }
}
