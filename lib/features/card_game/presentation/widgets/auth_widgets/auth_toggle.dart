import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTypeToggle extends StatelessWidget {
  final ValueNotifier<bool> isLogin;

  const AuthTypeToggle({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => isLogin.value = true,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(
                    color: isLogin.value ? Colors.white : Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => isLogin.value = false,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  'Register',
                  style: GoogleFonts.poppins(
                    color: isLogin.value ? Colors.grey : Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 4,
                  color: isLogin.value ? const Color(0xFFE7BB68) : Colors.grey,
                ),
              ),
              Expanded(
                child: Container(
                  height: 4,
                  color: !isLogin.value ? const Color(0xFFE7BB68) : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}