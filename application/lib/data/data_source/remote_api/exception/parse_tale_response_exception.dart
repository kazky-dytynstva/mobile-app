class ParseTaleResponseException implements Exception {
  final int taleId;
  final dynamic error;

  ParseTaleResponseException(
    this.taleId,
    this.error,
  );

  @override
  String toString() => 'Failed to parse response for tale with id:$taleId.\n'
      'error: $error';
}
