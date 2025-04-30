import 'package:flutter/material.dart';

import '../widgets/auth_widgets/auth_form.dart';
import '../widgets/auth_widgets/auth_toggle.dart';
import '../widgets/auth_widgets/forgot_password_button.dart';

class AuthDialog extends StatelessWidget {
  final ValueNotifier<bool> isLogin = ValueNotifier<bool>(true);

  AuthDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.93,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(18),
        ),
        child: ValueListenableBuilder<bool>(
          valueListenable: isLogin,
          builder: (context, value, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 35),
                AuthTypeToggle(isLogin: isLogin),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 800),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: AuthForm(
                    key: ValueKey<bool>(value),
                    emailController: emailController,
                    passwordController: passwordController,
                    isLogin: value,
                    onSubmit: () {
                      if (value) {
                        print('Logging in with email: ${emailController.text}');
                      } else {
                        print(
                          'Registering with email: ${emailController.text}',
                        );
                      }
                    },
                  ),
                ),
                ForgotPasswordButton(
                  onTap: () {
                    // Add forgot password logic here
                    print('Forgot Password tapped');
                  },
                ),
                const SizedBox(height: 35),
              ],
            );
          },
        ),
      ),
    );
  }
}
