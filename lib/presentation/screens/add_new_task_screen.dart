import 'package:flutter/material.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utility/urls.dart';
import 'package:task_management/presentation/controller/validator.dart';
import 'package:task_management/presentation/screens/auth/pin_verification_screen.dart';
import 'package:task_management/presentation/screens/new_task_screen.dart';
import 'package:task_management/presentation/widgets/background_wallpaper.dart';
import 'package:task_management/presentation/widgets/profile_bar.dart';

import '../widgets/snack_bar_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() =>
      _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isAddNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWallpaper(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 4),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    "Add New Task",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _titleTEController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                    validator: (String? value){
                      return Validator.textFieldValidator(value, 'Title');
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 5,
                    keyboardType: TextInputType.emailAddress,
                    controller: _descriptionTEController,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                    validator: (String? value){
                      return Validator.textFieldValidator(value, 'Description');
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _isAddNewTaskInProgress == false,
                        replacement: const Center(child: CircularProgressIndicator(),),
                        child: ElevatedButton(
                            onPressed: () async {
                              if(_formKey.currentState!.validate()){
                                await _addNewTask(context);
                                Navigator.pop(context);
                              }
                            },
                            child: const Icon(Icons.arrow_circle_right_rounded)),
                      )),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewTask(BuildContext context) async {
    _isAddNewTaskInProgress =true;
    setState(() {});
    
    Map<String,dynamic> inputParams = {
      "title":_titleTEController.text.trim(),
      "description":_descriptionTEController.text.trim(),
      "status":"New"
    };
    final response = await NetworkCaller.postRequest(Urls.addNewTask, inputParams);
    
    _isAddNewTaskInProgress = false;
    setState(() {});
    if(response.isSuccess){
      if(mounted){
        showSnackBarMessage(context, 'New task added.');
      }
    }
    else{
      if(mounted){
        showSnackBarMessage(context, 'Add new task Field! Please try again');
      }
    }
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
