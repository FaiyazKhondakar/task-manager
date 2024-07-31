import 'package:flutter/material.dart';

class TaskCounterCard extends StatelessWidget {
  const TaskCounterCard({
    super.key, required this.amount, required this.title,
  });
  final int? amount;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24 ,vertical: 16),
        child: Column(
          children: [
            Text('$amount',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
            Text(title!,style: const TextStyle(color: Colors.grey),),
          ],
        ),
      ),
    );
  }
}
