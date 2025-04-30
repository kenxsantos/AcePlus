import 'package:aceplus/features/card_game/presentation/home_page/widgets/cards/ace_card.dart';
import 'package:aceplus/features/card_game/presentation/home_page/widgets/cards/five_card.dart';
import 'package:aceplus/features/card_game/presentation/home_page/widgets/cards/four_card.dart';
import 'package:aceplus/features/card_game/presentation/home_page/widgets/cards/ten_card.dart';
import 'package:aceplus/features/card_game/presentation/home_page/widgets/cards/two_card.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [FourCard(), TwoCard(), FiveCard(), TenCard(), AceCard()],
    );
  }
}
