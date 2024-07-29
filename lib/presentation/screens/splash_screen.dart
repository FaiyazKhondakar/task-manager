import 'package:flutter/material.dart';
import 'package:task_management/presentation/controller/auth_controller.dart';
import 'package:task_management/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_management/presentation/screens/main_bottom_nav_screen.dart';
import 'package:task_management/presentation/widgets/background_wallpaper.dart';
import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    moveToNextScreen(context);
  }

  Future<void> moveToNextScreen(context) async {
    await Future.delayed(const Duration(seconds: 2));

    bool isLoggedIn = await AuthController.isUserLoggedIn();

    if(isLoggedIn ){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return const MainBottomNavScreen();
        }),
      );
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return const SignInScreen();
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackgroundWallpaper(
        child: Center(
          child: AppLogo(),
        ),
      )
    );
  }
}


