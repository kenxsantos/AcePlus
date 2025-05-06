import 'package:aceplus/features/card_game/presentation/auth_dialog/widgets/auth_textfield.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:aceplus/shared/utils/strings.dart';
import 'package:aceplus/shared/widgets/input_error_text.dart';
import 'package:aceplus/shared/widgets/solid_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/utils/validators.dart';
import '../../../../../shared/widgets/message_text.dart';
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
  final mobileNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileNumberError = ValueNotifier<String?>(null);
  final passwordError = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();

    mobileNumberController.addListener(() {
      final mobileNumberErrorText = validateMobileNumber(
        mobileNumberController.text.trim(),
      );
      mobileNumberError.value = mobileNumberErrorText;
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
          mobileNumberController.clear();
          passwordController.clear();
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
                MessageDisplay(message: message, messageColor: messageColor!),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthTextfield(
                    controller: mobileNumberController,
                    hintText: Str().enterMobileNumber,
                    obscureText: false,
                  ),
                  SizedBox(height: 5), // Add spacing
                  ValueListenableBuilder<String?>(
                    valueListenable: mobileNumberError,
                    builder: (context, error, child) {
                      if (error != null) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: InputErrorText(error: error),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthTextfield(
                    controller: passwordController,
                    hintText: Str().enterPass,
                    obscureText: true,
                  ),
                  SizedBox(height: 5), // Add spacing
                  ValueListenableBuilder<String?>(
                    valueListenable: passwordError,
                    builder: (context, error, child) {
                      if (error != null) {
                        return Align(
                          alignment: Alignment.centerRight,
                          // Align error to the right
                          child: InputErrorText(error: error),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
              SolidButton(
                labelText: Str().register.toUpperCase(),
                fontFamily: poppins,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  final mobileNumber = mobileNumberController.text.trim();
                  final password = passwordController.text.trim();

                  mobileNumberError.value = validateMobileNumber(mobileNumber);
                  passwordError.value = validatePassword(password);

                  if (mobileNumberError.value == null &&
                      passwordError.value == null) {
                    if (mobileNumber.isNotEmpty && password.isNotEmpty) {
                      final auth = Auth(
                        mobileNumber: mobileNumber,
                        password: password,
                      );
                      context.read<AuthBloc>().add(AddAuth(auth));
                    }
                  } else {
                    if (mobileNumber.isEmpty) {
                      mobileNumberError.value = "Mobile number is required";
                    }
                    if (password.isEmpty) {
                      passwordError.value = "Password is required";
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
