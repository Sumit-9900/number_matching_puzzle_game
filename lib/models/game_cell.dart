class GameCell {
  final int number;
  bool isHighlighted;
  bool isMatched;
  bool showError;

  GameCell({
    required this.number,
    this.isHighlighted = false,
    this.isMatched = false,
    this.showError = false,
  });
}
