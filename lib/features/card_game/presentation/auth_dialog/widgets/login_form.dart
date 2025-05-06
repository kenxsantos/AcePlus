import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:aceplus/shared/widgets/solid_button.dart';
import 'package:aceplus/shared/widgets/message_text.dart';
import '../auth_bloc/auth_bloc.dart';
import '../auth_bloc/auth_event.dart';
import '../auth_bloc/auth_state.dart';

import 'auth_textfield.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final mobileNumberController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          String? message;
          Color? messageColor;
          if (state is AuthLoginError) {
            message = state.message;
            messageColor = Color(0xFFF56C6C);
          } else if (state is AuthSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (message != null)
                MessageDisplay(message: message, messageColor: messageColor!),
              AuthTextfield(
                controller: mobileNumberController,
                hintText: Str().enterMobileNumber,
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
                onPressed: () {
                  final mobileNumber = mobileNumberController.text.trim();
                  final password = passwordController.text.trim();

                  context.read<AuthBloc>().add(
                    SearchAuth(mobileNumber, password),
                  );
                },
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
          );
        },
      ),
    );
  }
}
