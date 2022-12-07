enum TaleSortType {
  random,
  byName,
  byAuthor,
  byRating,
  byRatingAmount,
}

extension TaleSortTypeX on TaleSortType {
  bool get isRandom => this == TaleSortType.random;

  bool get ratingRelated =>
      this == TaleSortType.byRating || this == TaleSortType.byRatingAmount;
}
