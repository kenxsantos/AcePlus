part of 'card_bloc.dart';

enum CardStatus {
  initial,
  loading,
  loaded,
  error,
  generateCard,
  animateCard,
  cardTap,
}

extension CardStatusX on CardStatus {
  bool get isInitial => this == CardStatus.initial;
  bool get isLoading => this == CardStatus.loading;
  bool get isLoaded => this == CardStatus.loaded;
  bool get isError => this == CardStatus.error;
  bool get isCardGenerated => this == CardStatus.generateCard;
  bool get isAnimateCard => this == CardStatus.animateCard;
  bool get isCardTap => this == CardStatus.cardTap;
}

class CardState extends Equatable {
  final List<int> numbers;
  final List<double> odds;
  final bool isFlipped;
  final bool isExtended;
  final bool isTapped;
  final Set<int> tappedIndices;
  final bool isAce;
  final bool isJoker;
  final CardStatus status;

  const CardState({
    this.numbers = const [],
    this.odds = const [],
    this.isFlipped = false,
    this.isExtended = false,
    this.isTapped = false,
    this.tappedIndices = const {},
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
    Set<int>? tappedIndices,
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
      tappedIndices: tappedIndices ?? this.tappedIndices,
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
    tappedIndices,
    isAce,
    isJoker,
    status,
  ];
}
