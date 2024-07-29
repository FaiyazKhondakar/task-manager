import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

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
            const Text('Title will be here',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
            const Text('Description will be here',style: TextStyle(color: Colors.grey,),),
            const Text('Date: 12/01/24'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Chip(
                  label: const Text(
                    'New',
                    style: TextStyle(fontSize: 10),
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