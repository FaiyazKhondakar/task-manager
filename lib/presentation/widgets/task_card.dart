import 'package:flutter/material.dart';
import 'package:task_management/data/models/task_item.dart';
import 'package:task_management/presentation/widgets/snack_bar_message.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import '../utils/app_colors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskItem,
    required this.refreshList,
  });

  final TaskItem taskItem;
  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isUpdateTaskStatusInProgress = false;
  bool _isDeleteTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskItem.title ?? '',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              widget.taskItem.description ?? '',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            Text(widget.taskItem.createdDate ?? ''),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Chip(
                  label: Text(
                    widget.taskItem.status ?? '',
                    style: const TextStyle(fontSize: 10),
                  ),
                  backgroundColor: AppColors.themeColor,
                ),
                const Spacer(),
                Visibility(
                  visible: _isUpdateTaskStatusInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: IconButton(
                      onPressed: (){
                        _showUpdateStatusDialog(widget.taskItem.sId!, context);
                      },
                      icon: const Icon(
                        Icons.edit_off_outlined,
                        color: Colors.green,
                        size: 20,
                      )),
                ),
                Visibility(
                  visible: _isDeleteTaskInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: IconButton(
                      onPressed:(){
                        _deleteTaskById(widget.taskItem.sId!);
                      },
                      icon: const Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red,
                        size: 20,
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showUpdateStatusDialog(String id ,BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Select Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('New'),
                  onTap: () {
                    if(_checkCurrentStatus('New')){
                      return;
                    }
                    _updateTaskStatusById(id, 'New');
                    Navigator.pop(context);
                  },
                  trailing: _checkCurrentStatus('New') ? const Icon(Icons.check) : null,
                ),
                ListTile(
                  title: const Text('Completed'),
                  onTap: () {
                    if(_checkCurrentStatus('Completed')){
                      return;
                    }
                    _updateTaskStatusById(id, 'Completed');
                    Navigator.pop(context);
                  },
                  trailing: _checkCurrentStatus('Completed') ? const Icon(Icons.check) : null,
                ),
                ListTile(
                  title: const Text('Progress'),
                  onTap: () {
                    if(_checkCurrentStatus('Progress')){
                      return;
                    }
                    _updateTaskStatusById(id, 'Progress');
                    Navigator.pop(context);
                  },
                  trailing: _checkCurrentStatus('Progress') ? const Icon(Icons.check) : null,
                ),
                ListTile(
                  title: const Text('Cancelled'),
                  onTap: () {
                    if(_checkCurrentStatus('Cancelled')){
                      return;
                    }
                    _updateTaskStatusById(id, 'Cancelled');
                    Navigator.pop(context);
                  },
                  trailing: _checkCurrentStatus('Cancelled') ? const Icon(Icons.check) : null,
                ),
              ],
            ),
          );
        });
  }

  bool _checkCurrentStatus(String status){
    return widget.taskItem.status! == status;
  }

  Future<void> _updateTaskStatusById(String id, String status) async {
    _isUpdateTaskStatusInProgress = true;
    setState(() {});
    final response =
    await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));


    if (response.isSuccess) {
      widget.refreshList();
      _isUpdateTaskStatusInProgress = false;
      setState(() {});
    } else {
      _isUpdateTaskStatusInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMassage ?? 'Update task status has been field');
      }
    }
  }

  Future<void> _deleteTaskById(String id) async {
    _isDeleteTaskInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.deleteTask(id));
    _isDeleteTaskInProgress = false;
    if (response.isSuccess) {
      widget.refreshList();
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMassage ?? 'Delete task has been field');
      }
    }
  }
}
