class ParsePersonResponseException implements Exception {
  final int personId;
  final dynamic error;

  ParsePersonResponseException(
    this.personId,
    this.error,
  );

  @override
  String toString() =>
      'Failed to parse response for person with id:$personId.\n'
      'error: $error';
}
