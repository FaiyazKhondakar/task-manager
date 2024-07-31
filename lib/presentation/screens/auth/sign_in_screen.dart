import 'package:flutter/material.dart';
import 'package:task_management/data/models/signInResponse.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utility/urls.dart';
import 'package:task_management/presentation/controller/validator.dart';
import 'package:task_management/presentation/controller/auth_controller.dart';
import 'package:task_management/presentation/screens/auth/email_verification_screen.dart';
import 'package:task_management/presentation/screens/main_bottom_nav_screen.dart';
import 'package:task_management/presentation/screens/auth/sign_up_screen.dart';
import 'package:task_management/presentation/widgets/background_wallpaper.dart';
import 'package:task_management/presentation/widgets/snack_bar_message.dart';
import '../../../data/models/response_object.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSignInInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWallpaper(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Text(
                        'Get Start With',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTEController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        validator: (String? value){
                          return Validator.textFieldValidator(value, 'Email');
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _passwordTEController,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        validator: (String? value){
                          return Validator.textFieldValidator(value, 'Password');
                        },
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: _isSignInInProgress == false,
                            replacement: const Center(child: CircularProgressIndicator(),),
                            child: ElevatedButton(
                                onPressed: () async {

                                  if(_formKey.currentState!.validate()){
                                    _signIn();
                                  }

                                },
                                child: const Icon(Icons.arrow_circle_right_rounded)),
                          )),
                      const SizedBox(
                        height: 48,
                      ),
                      Center(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.grey,
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  )),
                              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> const EmailVerificationScreen()));},
                              child: const Text('Forget Password?'))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));}, child: const Text('Sign up'))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signIn() async{
    _isSignInInProgress =true;
    setState(() {});
    Map<String, dynamic> inputParams = {
      "email": _emailTEController.text.trim(),
      "password":_passwordTEController.text.trim(),
    };
    final ResponseObject response = await NetworkCaller.postRequest(Urls.logIn, inputParams , fromSignIn: true);
    _isSignInInProgress =false;
    setState(() {});
    if(response.isSuccess){
      if(!mounted){
        return;
      }
      SignInResponse signInResponse = SignInResponse.fromJson(response.responseBody);
      //save the data in local cache
      await AuthController.saveUserData(signInResponse.userData!);
      await AuthController.saveUserToken(signInResponse.token!);

      if(mounted){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                const MainBottomNavScreen()),
                (route) => false);
      }
    }
    else{
      if(mounted){
        showSnackBarMessage(context, response.errorMassage ?? 'Login Failed! Try again');
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
