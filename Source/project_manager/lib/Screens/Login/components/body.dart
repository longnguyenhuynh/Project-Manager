import 'package:flutter/material.dart';
import 'package:project_manager/Screens/Home/home_page.dart';
import 'package:project_manager/Screens/Login/components/background.dart';
import 'package:project_manager/Screens/Signup/signup_screen.dart';
import 'package:project_manager/components/already_have_an_account_acheck.dart';
import 'package:project_manager/components/rounded_button.dart';
import 'package:project_manager/components/rounded_input_field.dart';
import 'package:project_manager/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userName;
    String passWord;
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/owl.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Username",
              icon: Icons.account_circle,
              onChanged: (value) {
                userName = value;
                print(userName);
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                passWord = value;
                print(passWord);
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      getConnect(userName, passWord);
                      return HomePage();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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

  Future getConnect(String userName, String passWord) async {
    Map<String, String> loginInfo = {
      'userName': userName,
      'passWord': passWord,
    };
    print(loginInfo);
    var url = 'https://phuidatabase.000webhostapp.com/getData.php';
    String queryString = Uri(queryParameters: loginInfo).query;
    var requestUrl = url + '?' + queryString;
    print(requestUrl);
    http.Response response = await http.get(requestUrl);
    var data = jsonDecode(response.body);
    print(data.toString());
  }
}
