import 'package:assingment_task_menager/data/services/network_caller.dart';
import 'package:assingment_task_menager/data/utility/urls.dart';
import 'package:assingment_task_menager/presentation/screens/auth/pin_verification_screen.dart';
import 'package:assingment_task_menager/presentation/widgets/background_widget.dart';
import 'package:assingment_task_menager/presentation/widgets/form_validetor.dart';
import 'package:assingment_task_menager/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _EmailTEController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _emailVerifyInProgress = false;

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
                    "Your Email Address",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text(
                    "A 6 digit verification pin will send to your email address",
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    controller: _EmailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: FromValidator.emailValidetor,
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: _emailVerifyInProgress
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                        if(_formkey.currentState!.validate()){
                          _emailVerification();
                        }
                      },
                      child: const Icon(
                        Icons.arrow_circle_right_outlined,
                      ),
                    ),
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
                          Navigator.pop(context);
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
    _EmailTEController.dispose();
    super.dispose();
  }
  Future<void>_emailVerification()async{
       _emailVerifyInProgress =true;
       setState(() {});

    final response = await NetworkCaller.getRequest(
        Urls.RecoverVerifyEmail(_EmailTEController.text.trim()));
    _emailVerifyInProgress = false;
     if(response.isSuccess){
         setState(() {});
         if(mounted){
           Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) =>
               PinVerificationScreen(email: _EmailTEController.text.trim(),),
             ),
           );
         }
       }else{
         if (mounted) {
           showSnackBarMessage(context,
               'your habeen invalid');
         }
       }
  }
}
