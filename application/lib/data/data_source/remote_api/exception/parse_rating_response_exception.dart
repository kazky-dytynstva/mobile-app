class ParseRatingResponseException implements Exception {
  final int taleId;
  final dynamic error;

  ParseRatingResponseException(
    this.taleId,
    this.error,
  );

  @override
  String toString() =>
      'Failed to parse response for tale rating with with taleId:$taleId.\n'
      'error: $error';
}
