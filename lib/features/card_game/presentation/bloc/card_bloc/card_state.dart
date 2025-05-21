part of 'card_bloc.dart';

enum CardStatus {
  initial,
  loading,
  loaded,
  error,
  generateCard,
  animateCard,
  cardTap,
  placeBet,
}

extension CardStatusX on CardStatus {
  bool get isInitial => this == CardStatus.initial;
  bool get isLoading => this == CardStatus.loading;
  bool get isLoaded => this == CardStatus.loaded;
  bool get isError => this == CardStatus.error;
  bool get isCardGenerated => this == CardStatus.generateCard;
  bool get isAnimateCard => this == CardStatus.animateCard;
  bool get isCardTap => this == CardStatus.cardTap;
  bool get isPlaceBet => this == CardStatus.placeBet;
}

class CardState extends Equatable {
  final List<int> numbers;
  final List<double> odds;
  final bool isFlipped;
  final bool isExtended;
  final bool isTapped;
  final Map<int, double> bets;
  final int? lastSelectedCardIndex;
  final Map<int, double> totalAmount;
  final bool isAce;
  final bool isJoker;
  final CardStatus status;

  const CardState({
    this.numbers = const [],
    this.odds = const [],
    this.isFlipped = false,
    this.isExtended = false,
    this.isTapped = false,
    this.bets = const {},
    this.lastSelectedCardIndex,
    this.totalAmount = const {},
    this.isAce = false,
    this.isJoker = false,
    this.status = CardStatus.initial,
  });

  CardState copyWith({
    List<int>? numbers,
    List<double>? odds,
    bool? isFlipped,
    bool? isExtended,
    bool? isTapped,
    Map<int, double>? bets,
    int? lastSelectedCardIndex,
    Map<int, double>? totalAmount,
    double? selectedAmount,
    bool? isAce,
    bool? isJoker,
    CardStatus? status,
  }) {
    return CardState(
      numbers: numbers ?? this.numbers,
      odds: odds ?? this.odds,
      isFlipped: isFlipped ?? this.isFlipped,
      isExtended: isExtended ?? this.isExtended,
      isTapped: isTapped ?? this.isTapped,
      bets: bets ?? this.bets,
      totalAmount: totalAmount ?? this.totalAmount,
      lastSelectedCardIndex:
          lastSelectedCardIndex ?? this.lastSelectedCardIndex,
      isAce: isAce ?? this.isAce,
      isJoker: isJoker ?? this.isJoker,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    numbers,
    odds,
    isFlipped,
    isExtended,
    isTapped,
    bets,
    lastSelectedCardIndex,
    totalAmount,
    isAce,
    isJoker,
    status,
  ];
}
