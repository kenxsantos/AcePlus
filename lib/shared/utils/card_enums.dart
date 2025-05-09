import 'package:aceplus/shared/utils/constant.dart';

enum Cards {
  aceCard("Ace Card", "${cardUrl}ace.png", 1),
  twoCard("Two Card", "${cardUrl}two.png", 2),
  threeCard("Three Card", "${cardUrl}three.png", 3),
  fourCard("Four Card", "${cardUrl}four.png", 4),
  fiveCard("Five Card", "${cardUrl}five.png", 5),
  sixCard("Six Card", "${cardUrl}six.png", 6),
  sevenCard("Seven Card", "${cardUrl}seven.png", 7),
  eightCard("Eight Card", "${cardUrl}eight.png", 8),
  nineCard("Nine Card", "${cardUrl}nine.png", 9),
  tenCard("Ten Card", "${cardUrl}ten.png", 10);

  final String text;
  final String cardPath;
  final int value;

  const Cards(this.text, this.cardPath, this.value);
}
