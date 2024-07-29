import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management/presentation/screens/auth/set_password_screen.dart';
import 'package:task_management/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_management/presentation/utils/app_colors.dart';
import 'package:task_management/presentation/widgets/background_wallpaper.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEController = TextEditingController();
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
                Text("Pin Verification" , style: Theme.of(context).textTheme.titleLarge,),

                const SizedBox(
                  height: 4,
                ),
                const Text("A 6 digit verification pin will send to your email address" , style: TextStyle(color: Colors.grey,fontSize: 16)),

                const SizedBox(
                  height: 20,
                ),
                //pin text field
                PinCodeTextField(
                  controller: _pinTEController,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    inactiveColor: AppColors.themeColor,
                    selectedFillColor: Colors.transparent,
                    selectedColor: Colors.grey,
                    selectedBorderWidth: 4
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (v) {
                    // print("Completed");
                  },
                  appContext: context,
                ),

                const SizedBox(
                  height: 20,
                ),
                SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const SetPasswordScreen()));}, child: const Text('Verify'))),

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
    _pinTEController.dispose();
    super.dispose();
  }
}
