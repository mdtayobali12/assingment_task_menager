import 'package:assingment_task_menager/data/services/network_caller.dart';
import 'package:assingment_task_menager/data/utility/urls.dart';
import 'package:assingment_task_menager/presentation/widgets/background_widget.dart';
import 'package:assingment_task_menager/presentation/widgets/form_validetor.dart';
import 'package:assingment_task_menager/presentation/widgets/profile_appbar.dart';
import 'package:assingment_task_menager/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
 TextEditingController _titleTEColtroller = TextEditingController();
 TextEditingController _descriptionTEColtroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;
 bool _shouldRefreshNewTaskList= false;


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop){
        if(didPop){
          return;
        }
      Navigator.pop(context,_shouldRefreshNewTaskList);
      },
      child: Scaffold(
        appBar: ProfileAppBar,
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
                      height: 48.0,
                    ),
                    Text(
                      "Add New Task",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _titleTEColtroller,
                      decoration: const InputDecoration(hintText: "Title"),
                      validator: FromValidator.titleValidetor,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _descriptionTEColtroller,
                      maxLines: 6,
                      decoration: const InputDecoration(hintText: 'Description'),
                      validator: FromValidator.descriptionValidetor,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: _addNewTaskInProgress
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _addNewTask();
                          }
                        },
                        child: const Icon(
                          Icons.arrow_circle_right_outlined,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});
    Map<String, dynamic> inputParams = {
      "title":_titleTEColtroller.text.trim(),
      "description":_descriptionTEColtroller.text.trim(),
      "status":"New"
    };
    final response =
        await NetworkCaller.postRequest(Urls.createTask,inputParams);
    _addNewTaskInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _shouldRefreshNewTaskList =true;
      setState(() {});

      _titleTEColtroller.clear();
      _descriptionTEColtroller.clear();
      if (mounted) {
        showSnackBarMessage(context, 'New task has been added!');
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMassage ?? 'Add new task failed!', true);
      }
    }
  }

  @override
  void dispose() {
    _titleTEColtroller.dispose();
    _descriptionTEColtroller.dispose();
    super.dispose();
  }
}
