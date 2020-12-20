import 'package:flutter/material.dart';
import 'package:project_manager/Screens/Login/login_screen.dart';
import 'package:project_manager/Screens/Signup/components/background.dart';
import 'package:project_manager/Screens/Signup/components/or_divider.dart';
import 'package:project_manager/Screens/Signup/components/social_icon.dart';
import 'package:project_manager/components/already_have_an_account_acheck.dart';
import 'package:project_manager/components/rounded_button.dart';
import 'package:project_manager/components/rounded_input_field.dart';
import 'package:project_manager/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Name",
              icon: Icons.person,
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Username",
              icon: Icons.account_circle,
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Email",
              icon: Icons.mail,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
