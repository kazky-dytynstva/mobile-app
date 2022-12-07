import 'package:dartz/dartz.dart';

import 'utils/value_failure.dart';
import 'utils/value_object.dart';
import 'utils/value_validators.dart';

class IntPositive extends ValueObject<int> {
  static final IntPositive zero = IntPositive(0);

  factory IntPositive(int input) => IntPositive._(validateIntPositive(input));

  const IntPositive._(Either<ValueFailure<int>, int> value) : super(value);

  bool operator >(dynamic other) {
    if (other is num) {
      return get() > other;
    } else if (other is IntPositive) {
      return get() > other.get();
    } else {
      throw UnsupportedError('Can not execute operation');
    }
  }

  bool operator >=(dynamic other) {
    if (other is num) {
      return get() >= other;
    } else if (other is IntPositive) {
      return get() >= other.get();
    } else {
      throw UnsupportedError('Can not execute operation');
    }
  }

  bool operator <=(dynamic other) {
    if (other is num) {
      return get() <= other;
    } else if (other is IntPositive) {
      return get() <= other.get();
    } else {
      throw UnsupportedError('Can not execute operation');
    }
  }

  bool operator <(dynamic other) {
    if (other is num) {
      return get() < other;
    } else if (other is IntPositive) {
      return get() < other.get();
    } else {
      throw UnsupportedError('Can not execute operation');
    }
  }

  IntPositive operator +(dynamic other) {
    if (other is int) {
      return IntPositive(get() + other);
    } else if (other is IntPositive) {
      return IntPositive(get() + other.get());
    } else {
      throw UnsupportedError('Can not execute operation');
    }
  }

  int operator -(dynamic other) {
    if (other is int) {
      return get() - other;
    } else if (other is IntPositive) {
      return get() - other.get();
    } else {
      throw UnsupportedError('Can not execute operation');
    }
  }
}
