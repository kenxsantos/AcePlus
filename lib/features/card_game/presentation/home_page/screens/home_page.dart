import 'package:aceplus/features/card_game/presentation/home_page/widgets/button_container.dart';
import 'package:aceplus/features/card_game/presentation/home_page/widgets/header_container.dart';
import 'package:aceplus/features/card_game/presentation/home_page/widgets/image_container.dart';
import 'package:aceplus/features/card_game/presentation/home_page/widgets/roulette_container.dart';
import 'package:aceplus/features/card_game/presentation/home_page/widgets/text_container.dart';
import 'package:aceplus/shared/utils/constant.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(gradient: gradientBlack),
          child: Stack(
            children: [
              Column(
                children: [
                  HeaderContainer(),
                  TextContainer(),
                  ButtonContainer(),
                  Expanded(
                    child: Stack(
                      children: [RouletteContainer(), ImageContainer()],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 85,
                left: 15,
                width: 200,
                child: Image.asset("${imageUrl}light.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
