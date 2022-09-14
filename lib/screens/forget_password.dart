import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../connection/user_database_con.dart';
import '../models/user_model.dart';
import '../widgets/sizeSpace.dart';
import '../widgets/textfield_wiget.dart';
import 'login_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  TextEditingController _newPassController = TextEditingController();
  TextEditingController _newCPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Forget Password',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Bangers'),
                ),
              ),
              const SizeSpace(),
              TextFieldWidget(
                hintPassword: false,
                icons: Icons.person,
                controller: _userNameController,
                hintText: 'Enter User Name',
                label: 'UserName',
              ),
              SizeSpace(),
              TextFieldWidget(
                hintPassword: false,
                icons: Icons.mail_outlined,
                controller: _mainController,
                hintText: 'E-mail',
                label: 'Enter E-Mail',
              ),
              SizeSpace(),
              TextFieldWidget(
                hintPassword: true,
                icons: Icons.lock,
                controller: _newPassController,
                hintText: 'new password',
                label: 'Enter new password',
              ),
              SizeSpace(),
              TextFieldWidget(
                hintPassword: true,
                icons: Icons.lock_clock_outlined,
                controller: _newCPassController,
                hintText: 'new Confirm password',
                label: 'comfirm password',
              ),
              SizeSpace(),
              ElevatedButton(
                onPressed: () async {
                  // print(_userNameController.text);
                  // print(_mainController.text);
                  // print(_passwordController.text.isEmpty);
                  // print(_cpasswordController.text);
                  if (_userNameController.text.isEmpty ||
                      _mainController.text.isEmpty ||
                      _newPassController.text.isEmpty ||
                      _newCPassController.text.isEmpty) {
                    print('Field have null');
                  } else if (_newPassController.text.trim() !=
                      _newCPassController.text.trim()) {
                    print('Field Incorrect');
                  } else {
                    await UserDatabaseCon()
                        .updateUserAccount(
                          User(
                              email: _mainController.text.trim(),
                              password: _newPassController.text.trim(),
                              userName: _userNameController.text.trim(),
                              id: 0),
                        )
                        .whenComplete(() => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false));
                  }
                },
                child: Container(
                  height: 50,
                  width: 200,
                  child: const Center(
                    child: Text(
                      "save",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizeSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ready have an Account.!'),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Login')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
