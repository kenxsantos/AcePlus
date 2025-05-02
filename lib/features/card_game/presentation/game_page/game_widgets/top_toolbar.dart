import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopToolbarWidget extends StatelessWidget {
  const TopToolbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/top_toolbar.png',
          width: MediaQuery.of(context).size.width * 1,
          height: 75,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 32, // Adjust the height as needed
                child: ElevatedButton(
                  onPressed: () {
                    // Add cancel button functionality here
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
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 100,
                          height: 28,
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
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFD700),
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Positioned(
                          left: -15,
                          child: Image.asset('assets/images/chip.png', height: 30, width: 30),
                        ),
                        Positioned(
                          right: -15,
                          child: Image.asset('assets/images/add_button.png', height: 30, width: 30),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
