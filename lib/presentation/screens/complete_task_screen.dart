import 'package:flutter/material.dart';
import 'package:task_management/presentation/widgets/background_wallpaper.dart';
import '../widgets/profile_bar.dart';
import '../widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWallpaper(
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            // return const TaskCard();
          },
        ),
      ),
    );
  }
}
