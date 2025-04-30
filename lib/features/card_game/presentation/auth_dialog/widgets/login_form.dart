import 'package:aceplus/features/card_game/presentation/auth_dialog/widgets/auth_textfield.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:aceplus/shared/widgets/solid_button.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AuthTextfield(
            controller: emailController,
            hintText: Str().enterEmail,
            obscureText: false,
          ),
          AuthTextfield(
            controller: passwordController,
            hintText: Str().enterPass,
            suffixIcon: Icon(Icons.visibility_outlined),
            obscureText: true,
          ),
          SizedBox(height: 20),
          SolidButton(
            labelText: Str().logIn.toUpperCase(),
            fontFamily: poppins,
            onPressed: () => print("Logging In"),
          ),
          SizedBox(height: 15),
          Text(
            Str().fPass,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: primaryWhite,
              fontSize: 12,
              fontFamily: poppins,
            ),
          ),
        ],
      ),
    );
  }
}
