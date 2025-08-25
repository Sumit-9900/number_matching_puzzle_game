class GameCell {
  final int number;
  bool isHighlighted;
  bool isMatched;

  GameCell({
    required this.number,
    this.isHighlighted = false,
    this.isMatched = false,
  });
}
