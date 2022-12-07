import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failure.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.exceedingLength({
    required T failedValue,
    required int max,
  }) = ValueFailureExceedingLength<T>;

  const factory ValueFailure.deficiencyLength({
    required T failedValue,
    required int min,
  }) = ValueFailureDeficiencyLength<T>;

  const factory ValueFailure.empty({
    required String failedValue,
  }) = ValueFailureEmptyString<T>;

  const factory ValueFailure.multilineString({
    required String failedValue,
  }) = ValueFailureMultilineString<T>;

  const factory ValueFailure.numberTooSmall({
    required T failedValue,
    required num min,
  }) = ValueFailureNumberTooSmall<T>;

  const factory ValueFailure.numberTooLarge({
    required T failedValue,
    required num max,
  }) = ValueFailureNumberTooLarge<T>;

  const factory ValueFailure.invalidEmail({
    required String failedValue,
  }) = ValueFailureInvalidEmail<T>;
}
