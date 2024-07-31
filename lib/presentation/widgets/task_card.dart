import 'package:flutter/material.dart';
import 'package:task_management/data/models/task_item.dart';

import '../utils/app_colors.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key, required this.taskItem,
  });
  final TaskItem taskItem;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(taskItem.title ?? '',style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
            Text(taskItem.description ?? '',style: const TextStyle(color: Colors.grey,),),
            Text(taskItem.createdDate ?? ''),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Chip(
                  label: Text(
                    taskItem.status ?? '',
                    style: const TextStyle(fontSize: 10),
                  ),
                  backgroundColor: AppColors.themeColor,
                ),
                const Spacer(),
                IconButton(onPressed: (){}, icon: const Icon(Icons.edit_off_outlined,color: Colors.green,size: 20,)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.delete_forever_outlined,color: Colors.red,size: 20,))
              ],
            )
          ],
        ),
      ),
    );
  }
}