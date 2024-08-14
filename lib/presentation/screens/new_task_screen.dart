import 'package:flutter/material.dart';
import 'package:task_management/data/models/count_by_status_wrapper.dart';
import 'package:task_management/data/models/task_list_wrapper.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utility/urls.dart';
import 'package:task_management/presentation/screens/add_new_task_screen.dart';
import 'package:task_management/presentation/utils/app_colors.dart';
import 'package:task_management/presentation/widgets/background_wallpaper.dart';
import 'package:task_management/presentation/widgets/snack_bar_message.dart';
import '../widgets/profile_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _isGetAllTaskCountByStatusInProgress = false;
  bool _isGetNewTaskInProgress = false;
  CountByStatusWrapper? _countByStatusWrapper = CountByStatusWrapper();
  TaskListWrapper? _taskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getDataFromApis();
  }

  void _getDataFromApis() {
    _getAllTaskCountByStatus();
    _getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWallpaper(
        child: Column(
          children: [
            Visibility(
                visible: _isGetAllTaskCountByStatusInProgress == false,
                replacement: const Center(
                  child: LinearProgressIndicator(),
                ),
                child: taskCounterSection()),
            Expanded(
              child: Visibility(
                visible: _isGetNewTaskInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: () async => _getDataFromApis(),
                  child: Visibility(
                    visible: _taskListWrapper?.taskList?.isNotEmpty ?? false,
                    child: ListView.builder(
                      itemCount: _taskListWrapper?.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskItem: _taskListWrapper!.taskList![index],
                          refreshList: () => _getDataFromApis() ,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        onPressed: () async {
          final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewTaskScreen()));

          if(result !=null && result == true){
            _getDataFromApis();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  SizedBox taskCounterSection() {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          itemCount: _countByStatusWrapper?.listOfTaskByStatusData?.length ?? 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TaskCounterCard(
                amount:
                    _countByStatusWrapper?.listOfTaskByStatusData![index].sum,
                title:
                    _countByStatusWrapper?.listOfTaskByStatusData![index].sId ??
                        ' ');
          },
          separatorBuilder: (_, __) {
            return const SizedBox(width: 16);
          },
        ),
      ),
    );
  }

  Future<void> _getAllTaskCountByStatus() async {
    _isGetAllTaskCountByStatusInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);
    if (response.isSuccess) {
      if (mounted) {
        _countByStatusWrapper =
            CountByStatusWrapper.fromJson(response.responseBody);
        _isGetAllTaskCountByStatusInProgress = false;
        setState(() {});
      }
    } else {
      _isGetAllTaskCountByStatusInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMassage ?? 'Get task count by status has been field');
      }
    }
  }

  Future<void> _getNewTaskList() async {
    _isGetNewTaskInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.newTaskList);

    if (response.isSuccess) {
      _taskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _isGetNewTaskInProgress = false;
      setState(() {});
    } else {
      _isGetNewTaskInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMassage ?? 'Get new task list has been field');
      }
    }
  }

}
