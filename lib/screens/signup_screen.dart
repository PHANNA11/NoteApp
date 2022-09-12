import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:note_app1/connection/user_database_con.dart';
import 'package:note_app1/models/user_model.dart';

import '../widgets/sizeSpace.dart';
import '../widgets/textfield_wiget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

TextEditingController _mainController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _userNameController = TextEditingController();
TextEditingController _cpasswordController = TextEditingController();

class _SignUpScreenState extends State<SignUpScreen> {
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
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Bangers'),
                ),
              ),
              SizeSpace(),
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
                controller: _passwordController,
                hintText: 'password',
                label: 'Enter password',
              ),
              SizeSpace(),
              TextFieldWidget(
                hintPassword: true,
                icons: Icons.lock_clock_outlined,
                controller: _cpasswordController,
                hintText: 'Enter Confirm password',
                label: 'Confirm password',
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
                      _passwordController.text.isEmpty ||
                      _cpasswordController.text.isEmpty) {
                    print('Field have null');
                  } else if (_passwordController.text.trim() !=
                      _cpasswordController.text.trim()) {
                    print('Field Incorrect');
                  } else {
                    await UserDatabaseCon().insertUserData(
                      User(
                          id: Random().nextInt(10000),
                          email: _mainController.text.trim(),
                          password: _passwordController.text.trim(),
                          userName: _userNameController.text.trim()),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: 200,
                  child: const Center(
                    child: Text(
                      "Create",
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
                  Text('Ready have an Account.!'),
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
