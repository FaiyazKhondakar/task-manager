import 'package:flutter/material.dart';
import 'package:task_management/presentation/screens/auth/pin_verification_screen.dart';
import 'package:task_management/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_management/presentation/widgets/background_wallpaper.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _confirmPasswordTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWallpaper(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28 ,vertical: 4),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text("Set Password" , style: Theme.of(context).textTheme.titleLarge,),

                const SizedBox(
                  height: 4,
                ),
                const Text("Minimum length password 8 character with letter and number combination" , style: TextStyle(color: Colors.grey,fontSize: 16)),


                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _passwordTEController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _confirmPasswordTEController,
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                  ),
                ),


                const SizedBox(
                  height: 20,
                ),
                SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){}, child: const Text('Confirm'))),

                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have Account?"),
                    TextButton(onPressed: () {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const SignInScreen()), (route) => false);}, child: const Text('Sign in'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
