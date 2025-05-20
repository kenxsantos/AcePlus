import 'package:aceplus/features/card_game/presentation/widgets/home_page_widgets/cards/ace_card.dart';
import 'package:aceplus/features/card_game/presentation/widgets/home_page_widgets/cards/five_card.dart';
import 'package:aceplus/features/card_game/presentation/widgets/home_page_widgets/cards/four_card.dart';
import 'package:aceplus/features/card_game/presentation/widgets/home_page_widgets/cards/six_card.dart';
import 'package:aceplus/features/card_game/presentation/widgets/home_page_widgets/cards/ten_card.dart';
import 'package:aceplus/features/card_game/presentation/widgets/home_page_widgets/cards/two_card.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SixCard(),
        FourCard(),
        TwoCard(),
        FiveCard(),
        TenCard(),
        AceCard(),
      ],
    );
  }
}
