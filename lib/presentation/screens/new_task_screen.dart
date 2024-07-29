import 'package:flutter/material.dart';
import 'package:task_management/presentation/screens/add_new_task_screen.dart';
import 'package:task_management/presentation/utils/app_colors.dart';
import 'package:task_management/presentation/widgets/background_wallpaper.dart';
import '../widgets/profile_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar,
      body: BackgroundWallpaper(
        child: Column(
          children: [
            taskCounterSection(),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const TaskCard();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddNewTaskScreen()));},
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
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const TaskCounterCard(amount: 12, title: 'New');
          },
          separatorBuilder: (_, __) {
            return const SizedBox(width: 16);
          },
        ),
      ),
    );
  }
}
