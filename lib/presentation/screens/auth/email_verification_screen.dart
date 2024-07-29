import 'package:flutter/material.dart';
import 'package:task_management/presentation/screens/auth/pin_verification_screen.dart';
import 'package:task_management/presentation/widgets/background_wallpaper.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController = TextEditingController();
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
                Text("Your Email Address" , style: Theme.of(context).textTheme.titleLarge,),

                const SizedBox(
                  height: 4,
                ),
                const Text("A 6 digit verification pin will send to your email address" , style: TextStyle(color: Colors.grey,fontSize: 16)),


                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),


                const SizedBox(
                  height: 20,
                ),
                SizedBox(width: double.infinity,child: ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const PinVerificationScreen()));}, child: const Icon(Icons.arrow_circle_right_rounded))),

                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have Account?"),
                    TextButton(onPressed: () {Navigator.pop(context);}, child: const Text('Sign in'))
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
    _emailTEController.dispose();
    super.dispose();
  }
}
