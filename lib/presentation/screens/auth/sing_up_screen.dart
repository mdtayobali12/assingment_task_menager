import 'package:assingment_task_menager/presentation/controllers/sinup_controller.dart';
import 'package:assingment_task_menager/presentation/widgets/form_validetor.dart';
import 'package:assingment_task_menager/presentation/widgets/background_widget.dart';
import 'package:assingment_task_menager/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final TextEditingController _EmailTEController = TextEditingController();
  final TextEditingController _FirstNameTEController = TextEditingController();
  final TextEditingController _LastNameTEController = TextEditingController();
  final TextEditingController _MobileTEController = TextEditingController();
  final TextEditingController _PasswordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SingUpController _singUpController = Get.find<SingUpController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 60.0,
                  ),
                  Text(
                    "Join with Us",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _EmailTEController,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: FromValidator.emailValidetor,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _FirstNameTEController,
                    decoration: const InputDecoration(hintText: 'First Name'),
                    validator: FromValidator.fatNamelValidetor,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _LastNameTEController,
                    decoration: const InputDecoration(hintText: 'Last Name'),
                    validator: FromValidator.lastNameValidetor,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _MobileTEController,
                    decoration: const InputDecoration(hintText: 'Mobile'),
                    validator: FromValidator.mobileNoValidetor,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                      controller: _PasswordTEController,
                      decoration: const InputDecoration(hintText: 'password'),
                      validator: FromValidator.passwordValidetor),
                  const SizedBox(height: 16.0),
                  GetBuilder<SingUpController>(
                    builder: (singUpController) {
                      return SizedBox(
                        width: double.infinity,
                        child: singUpController.inProgress
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  if(_formKey.currentState!.validate()){
                                  _signUp();
                                  }
                                },
                                child: const Icon(
                                  Icons.arrow_circle_right_outlined,
                                ),
                              ),
                      );
                    }
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
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
  Future<void> _signUp() async{
    final result = await _singUpController.singUp(
        _EmailTEController.text.trim(),
        _FirstNameTEController.text.trim(),
        _LastNameTEController.text.trim(),
        _MobileTEController.text.trim(),
        _PasswordTEController.text);

    if (result) {
      if (mounted) {
        showSnackBarMessage(context,
            _singUpController.errorMessageSuccess);
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context,
           _singUpController.errorMessage );
      }
    }
  }

  @override
  void dispose() {
   _EmailTEController.dispose();
   _FirstNameTEController.dispose();
   _LastNameTEController.dispose();
   _MobileTEController.dispose();
   _PasswordTEController.dispose();
    super.dispose();
  }
}
