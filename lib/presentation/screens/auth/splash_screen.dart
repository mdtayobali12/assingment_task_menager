import 'package:assingment_task_menager/presentation/controllers/auth_controller.dart';
import 'package:assingment_task_menager/presentation/screens/auth/sing_in_screen.dart';
import 'package:assingment_task_menager/presentation/screens/main_bottom_nav_screen.dart';
import 'package:assingment_task_menager/presentation/widgets/app_logo.dart';
import 'package:assingment_task_menager/presentation/widgets/background_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToSingIn();
  }
  Future<void> _moveToSingIn() async {
    await Future.delayed(const Duration(seconds: 3));
   bool loginState = await AuthController.isUserLogedIn();
    if (mounted) {
      if(loginState) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainBottomNavScreen(),
          ),
        );

      } else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SingInScreen(),
          ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: AppLogo(),
        ),
      ),
    );
  }
}
