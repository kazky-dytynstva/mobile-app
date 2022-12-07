enum RatingType {
  awesome(5),
  like(4),
  moderate(3),
  dislike(2),
  terrible(1);

  final int mark;

  const RatingType(this.mark);
}
