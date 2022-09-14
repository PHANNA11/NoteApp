import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app1/connection/user_database_con.dart';
import 'package:note_app1/screens/forget_password.dart';
import 'package:note_app1/screens/home_screen.dart';
import 'package:note_app1/screens/signup_screen.dart';
import 'package:note_app1/widgets/sizeSpace.dart';
import 'package:note_app1/widgets/textfield_wiget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mainController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Sign In',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Bangers'),
              ),
            ),
            SizeSpace(),
            TextFieldWidget(
              hintPassword: false,
              icons: Icons.mail_outlined,
              controller: mainController,
              hintText: 'E-mail',
              label: 'Enter E-Mail',
            ),
            SizeSpace(),
            TextFieldWidget(
              hintPassword: true,
              icons: Icons.lock,
              controller: passwordController,
              hintText: 'password',
              label: 'Enter password',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgetPasswordScreen(),
                          ),
                          (route) => false);
                    },
                    child: const Text('forget password')),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                await UserDatabaseCon()
                    .userLoginData(mainController.text.trim(),
                        passwordController.text.trim())
                    .then((value) {
                  print(value.userName);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false);
                });
              },
              child: Container(
                height: 50,
                width: 200,
                child: const Center(
                  child: Text(
                    "login",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizeSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an Account?'),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ));
                    },
                    child: const Text('Sign Up')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
