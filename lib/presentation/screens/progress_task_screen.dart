import 'package:flutter/material.dart';
import 'package:task_management/presentation/widgets/background_wallpaper.dart';
import '../widgets/profile_bar.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWallpaper(
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            // return const TaskCard();
          },
        ),
      ),
    );
  }
}
