// GameCell: state for a single grid item.
// Flags control UI: highlight (selected), matched (faded), showError (flash).
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
