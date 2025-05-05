import 'package:aceplus/shared/utils/strings.dart';
import 'package:aceplus/shared/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth_dialog/screens/auth_dialog.dart';

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({super.key});

  Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<String?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    return userId?.toString();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isLoggedIn(),
      builder: (context, snapshot) {
        final isLoggedIn = snapshot.data ?? false;

        return Container(
          margin: EdgeInsets.only(top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GradientButton(
                labelText: Str().playNow,
                onPressed: () async {
                  if (isLoggedIn) {
                    final userId = await _getUserId();
                    print(userId);
                    if(context.mounted) {
                      context.go('/game/$userId');
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AuthDialog(),
                    );
                  }
                },
              ),
              if (isLoggedIn)
                GradientButton(
                  labelText: Str().wallet,
                  onPressed: () => context.goNamed("wallet"),
                ),
            ],
          ),
        );
      },
    );
  }
}
