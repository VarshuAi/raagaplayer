class RecommendationWeights {
  final double playCountWeight;
  final double skipPenalty;
  final double favoriteBonus;
  final double completionBonus;
  final double recencyBonus;
  final double recencyHalfLifeDays;

  const RecommendationWeights({
    this.playCountWeight = 2.5,
    this.skipPenalty = 2.0,
    this.favoriteBonus = 5.0,
    this.completionBonus = 3.0,
    this.recencyBonus = 1.5,
    this.recencyHalfLifeDays = 30.0,
  });
}
