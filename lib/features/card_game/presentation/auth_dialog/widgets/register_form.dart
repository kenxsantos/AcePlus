import 'package:aceplus/features/card_game/presentation/auth_dialog/widgets/auth_textfield.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:aceplus/shared/widgets/input_error_text.dart';
import 'package:aceplus/shared/widgets/solid_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/utils/validators.dart';
import '../auth_bloc/auth_bloc.dart';
import '../auth_bloc/auth_event.dart';
import '../../../../../core/model/auth_model/auth_model.dart';
import '../auth_bloc/auth_state.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailError = ValueNotifier<String?>(null);
  final passwordError = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();

    emailController.addListener(() {
      final emailErrorText = validateEmail(emailController.text.trim());
      emailError.value = emailErrorText;
    });

    passwordController.addListener(() {
      final passwordErrorText = validatePassword(
        passwordController.text.trim(),
      );
      passwordError.value = passwordErrorText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String? message;
        Color? messageColor;

        if (state is AuthSuccess) {
          message = state.message;
          messageColor = Colors.green;
          emailController.clear();
          passwordController.clear();
          emailError.value = null;
          passwordError.value = null;
        } else if (state is AuthError) {
          message = state.message;
          messageColor = Colors.red;
        }

        return Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (message != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Center(
                    child: Text(
                      message,
                      style: TextStyle(
                        color: messageColor,
                        fontSize: 12,
                        fontFamily: poppins,
                      ),
                    ),
                  ),
                ),
              AuthTextfield(
                controller: emailController,
                hintText: Str().enterEmail,
                obscureText: false,
              ),
              ValueListenableBuilder<String?>(
                valueListenable: emailError,
                builder: (context, error, child) {
                  if (error != null) {
                    return InputErrorText(error: error);
                  }
                  return SizedBox.shrink();
                },
              ),
              AuthTextfield(
                controller: passwordController,
                hintText: Str().enterPass,
                obscureText: true,
              ),
              ValueListenableBuilder<String?>(
                valueListenable: passwordError,
                builder: (context, error, child) {
                  if (error != null) {
                    return InputErrorText(error: error);
                  }
                  return SizedBox.shrink();
                },
              ),
              SizedBox(height: 10),
              SolidButton(
                labelText: Str().register.toUpperCase(),
                fontFamily: poppins,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();

                  if (email.isNotEmpty && password.isNotEmpty) {
                    final auth = Auth(email: email, password: password);
                    context.read<AuthBloc>().add(AddAuth(auth));
                  } else {
                    if (email.isEmpty) {
                      emailError.value = "Email is Required";
                    }
                    if (password.isEmpty) {
                      passwordError.value = "Password is Required";
                    }
                  }
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
          ),
        );
      },
    );
  }
}
