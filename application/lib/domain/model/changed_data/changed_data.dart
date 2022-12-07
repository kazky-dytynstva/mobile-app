class ChangedData<Data, Id> {
  final dynamic _value;

  ChangedData._(this._value);

  factory ChangedData.updated(Data data) => ChangedData._(data);

  factory ChangedData.deleted(Id id) => ChangedData._(id);

  T map<T>({
    required T Function(Id identifier) deleted,
    required T Function(Data data) updated,
  }) {
    if (isUpdated) {
      return updated(_value as Data);
    } else {
      return deleted(_value as Id);
    }
  }

  bool get isUpdated => _value is Data;

  bool get isDeleted => !isUpdated;
}
