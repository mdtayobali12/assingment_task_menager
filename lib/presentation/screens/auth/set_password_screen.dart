import 'package:assingment_task_menager/data/services/network_caller.dart';
import 'package:assingment_task_menager/data/utility/urls.dart';
import 'package:assingment_task_menager/presentation/screens/main_bottom_nav_screen.dart';
import 'package:assingment_task_menager/presentation/screens/auth/sing_in_screen.dart';
import 'package:assingment_task_menager/presentation/widgets/background_widget.dart';
import 'package:assingment_task_menager/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key, required this.email, required this.otp});
  final String email;
  final String otp;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _PasswordTEController = TextEditingController();
  final TextEditingController _ConfirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _setpasswordInprogress = false;

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
                    "Set Password",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text(
                    "Minimum 8 characters with letters and number combination",
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    controller: _PasswordTEController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    controller: _ConfirmPasswordTEController,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child:_setpasswordInprogress?const Center(child: CircularProgressIndicator(),): ElevatedButton(
                        onPressed: () {
                          setPasswordApi();
                        },
                        child: const Text('Confirm')),
                  ),
                  const SizedBox(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have account?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SingInScreen(),
                              ),
                              (route) => false);
                        },
                        child: const Text('Sing in'),
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
  Future<void> setPasswordApi() async {
    _setpasswordInprogress  = true;
    setState(() {});
    Map<String, dynamic> inputparams = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _PasswordTEController.text
    };
    final respons =
    await NetworkCaller.postRequest(Urls.RecoverResetPass, inputparams);
    _setpasswordInprogress = false;
    if (respons.isSuccess) {
      setState(() {

      });
      if(!mounted){
        return;
      }
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => SingInScreen(),
          ),
              (route) => false);
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context, "Invalid password");
      }
    }
  }
  @override
  void dispose() {
    _PasswordTEController.dispose();
    _ConfirmPasswordTEController.dispose();
    super.dispose();
  }

}
