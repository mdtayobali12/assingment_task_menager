import 'package:assingment_task_menager/presentation/controllers/singin_controller.dart';
import 'package:assingment_task_menager/presentation/widgets/form_validetor.dart';
import 'package:assingment_task_menager/presentation/screens/auth/email_verification_screen.dart';
import 'package:assingment_task_menager/presentation/screens/auth/sing_up_screen.dart';
import 'package:assingment_task_menager/presentation/screens/main_bottom_nav_screen.dart';
import 'package:assingment_task_menager/presentation/utils/app_colors.dart';
import 'package:assingment_task_menager/presentation/widgets/background_widget.dart';
import 'package:assingment_task_menager/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final TextEditingController _EmailTEController = TextEditingController();
  final TextEditingController _PasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final SingInController _singInController = Get.find<SingInController>();
  var _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    "Get Started with",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _EmailTEController,
                    validator: FromValidator.emailValidetor,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _PasswordTEController,
                    validator: FromValidator.passwordValidetor,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: _obscureText
                            ? Icon(Icons.visibility,
                                color: AppColors.themeColor)
                            : Icon(Icons.visibility_off,
                                color: AppColors.themeColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  GetBuilder<SingInController>(builder: (_) {
                    return SizedBox(
                      width: double.infinity,
                      child: _singInController.inProgress
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  _singIn();
                                }
                              },
                              child: const Icon(
                                Icons.arrow_circle_right_outlined,
                              ),
                            ),
                    );
                  }),
                  const SizedBox(height: 60.0),
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.grey,
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const EmailVerificationScreen(),
                          ),
                        );
                      },
                      child: const Text('Forgot Password'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have and account?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SingUpScreen(),
                            ),
                          );
                        },
                        child: const Text('Sing Up'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _singIn() async {
    final result = await _singInController.singIn(
      _EmailTEController.text.trim(),
      _PasswordTEController.text,
    );
    if (result) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainBottomNavScreen(),
            ),
            (route) => false);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            _singInController.errorMessage);
      }
    }
  }

  @override
  void dispose() {
    _EmailTEController.dispose();
    _PasswordTEController.dispose();
    super.dispose();
  }
}
