import 'package:flutter/material.dart';
import 'package:task_management/presentation/utils/app_colors.dart';
import 'package:task_management/presentation/widgets/background_wallpaper.dart';
import '../widgets/profile_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar,
      body: BackgroundWallpaper(
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return const TaskCard();
          },
        ),
      ),
    );
  }
}
