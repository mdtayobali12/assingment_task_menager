import 'package:assingment_task_menager/data/models/response_object.dart';
import 'package:assingment_task_menager/presentation/widgets/form_validetor.dart';
import 'package:assingment_task_menager/data/services/network_caller.dart';
import 'package:assingment_task_menager/data/utility/urls.dart';
import 'package:assingment_task_menager/presentation/widgets/background_widget.dart';
import 'package:assingment_task_menager/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';

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

  bool _isRegistrationInProgress = false;

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
                  SizedBox(
                    width: double.infinity,
                    child:_isRegistrationInProgress?const Center(child: CircularProgressIndicator()): ElevatedButton(
                      onPressed: () {
                        singUp();
                      },
                      child: const Icon(
                        Icons.arrow_circle_right_outlined,
                      ),
                    ),
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
      Future<void> singUp()async {
        if (_formKey.currentState!.validate()) {
          _isRegistrationInProgress = true;
          setState(() {});

          Map<String, dynamic> inputParams = {
            "email": _EmailTEController.text.trim(),
            "firstName": _FirstNameTEController.text.trim(),
            "lastName": _LastNameTEController.text.trim(),
            "mobile": _MobileTEController.text.trim(),
            "password": _PasswordTEController.text
          };
          final ResponseObject response =
          await NetworkCaller.postRequest(
              Urls.registration, inputParams);
          _isRegistrationInProgress = false;
          setState(() {});

          if (response.isSuccess) {
            if (mounted) {
              showSnackBarMessage(context,
                  'Registration Completed! please login.');
              Navigator.pop(context);
            }
          } else {
            if (mounted) {
              showSnackBarMessage(context,
                  'Registration Failed . Try again', true);
            }
          }
        }

      }
  @override
  void dispose() {
    _EmailTEController.dispose();
    _PasswordTEController.dispose();
    _LastNameTEController.dispose();
    _FirstNameTEController.dispose();
    _EmailTEController.dispose();
    super.dispose();
  }
}
