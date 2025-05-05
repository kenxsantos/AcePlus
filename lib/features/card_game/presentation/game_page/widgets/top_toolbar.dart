import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TopToolbarWidget extends StatelessWidget {
  const TopToolbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final toolbarHeight = screenWidth * 0.23;
    final buttonHeight = toolbarHeight * 0.325;
    final chipSize = toolbarHeight * 0.3;
    final addButtonSize = toolbarHeight * 0.3;
    final containerWidth = screenWidth * 0.23;
    final containerHeight = toolbarHeight * 0.28;
    final fontSize = toolbarHeight * 0.12;

    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/top_toolbar.png',
          width: screenWidth,
          height: toolbarHeight,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: buttonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD700),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: const BorderSide(
                        color: Color(0xFF7D1F22),
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Text(
                    'Leave',
                    style: GoogleFonts.lemon(
                      textStyle: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.04),
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: containerWidth,
                          height: containerHeight,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF505050), Color(0xFF313131)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '100000',
                              style: GoogleFonts.lemon(
                                textStyle: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFD700),
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Positioned(
                          left: -chipSize * 0.5,
                          child: Image.asset(
                            'assets/images/chip.png',
                            height: chipSize,
                            width: chipSize,
                          ),
                        ),
                        Positioned(
                          right: -addButtonSize * 0.5,
                          child: Image.asset(
                            'assets/images/add_button.png',
                            height: addButtonSize,
                            width: addButtonSize,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
