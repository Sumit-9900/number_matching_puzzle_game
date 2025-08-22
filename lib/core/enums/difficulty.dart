enum Difficulty { easy, medium, hard }

String difficultyString(Difficulty diff) {
  switch (diff) {
    case Difficulty.easy:
      return 'Level 1';
    case Difficulty.medium:
      return 'Level 2';
    case Difficulty.hard:
      return 'Level 3';
  }
}
