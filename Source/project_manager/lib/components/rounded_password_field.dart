import 'package:flutter/material.dart';
import 'package:project_manager/components/text_field_container.dart';
import 'package:project_manager/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  var passwordObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: passwordObscured,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              passwordObscured ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            ),
            onPressed: () {
              setState(() {
                passwordObscured = !passwordObscured;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
