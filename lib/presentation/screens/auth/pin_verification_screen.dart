import 'package:assingment_task_menager/data/utility/urls.dart';
import 'package:assingment_task_menager/presentation/screens/auth/set_password_screen.dart';
import 'package:assingment_task_menager/presentation/screens/auth/sing_in_screen.dart';
import 'package:assingment_task_menager/presentation/utils/app_colors.dart';
import 'package:assingment_task_menager/presentation/widgets/background_widget.dart';
import 'package:assingment_task_menager/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key, required this.email});

  final String email;


  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _PinTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _pinVerificationInProgress = false;

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
                    "Pin Verification",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text(
                    "A 6 digit verification pin will send to your email address",
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  PinCodeTextField(
                    keyboardType: TextInputType.number,
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.circle,
                        fieldHeight: 50,
                        fieldWidth: 50,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        inactiveColor: AppColors.themeColor,
                        selectedFillColor: Colors.white),
                    animationDuration: const Duration(microseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    onCompleted: (v) {},
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: _pinVerificationInProgress
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                            _pintVarification();
                            },
                            child: const Text("Verify")),
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

  @override
  void dispose() {
    _PinTEController.dispose();
    super.dispose();
  }
  Future<void>  _pintVarification() async {
    setState(() {
      _pinVerificationInProgress = true;
    });
    http.Response response = await http.get(Uri.parse(Urls.RecoverVerifyOTP(
      widget.email,
      _PinTEController.text,
    )));
    _pinVerificationInProgress = false;
    print(response.body);
    setState(() {});
    if (response.statusCode==200) {
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  SetPasswordScreen(email:widget.email, otp: _PinTEController.text),
            ),
        );

      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, "wrong OTP");
      }
    }
  }
}
