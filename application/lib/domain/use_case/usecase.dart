import 'dart:async';
import 'package:meta/meta.dart';

class Dry {
  const Dry._();
}

const Dry dry = Dry._();

typedef Listener<Output> = Function(Output output);

/// For advanced output use next:
/// ```dart
/// import 'package:freezed_annotation/freezed_annotation.dart';
/// @Freezed(
///   maybeMap: false,
///   maybeWhen: false,
/// )
/// abstract class UseCaseOutput with _$UseCaseOutput {
///   UseCaseOutput._();
///
///   const factory UseCaseOutput.success(Data data) = _Data;
///
///   const factory UseCaseOutput.failure(Failure failure) = _Failure;
/// }
/// ```
abstract class UseCase<Input, Output> {
  /// Should be overridden in the successor of the [UseCase]
  @visibleForOverriding
  Stream<Output> transaction(Input input);

  /// Return single (first) [Output] from the [transaction]
  Future<Output> call(Input input) => transaction(input).first;

  /// Return [UseCaseSubscription], so you can unsubscribe from result
  /// If [UseCaseSubscription.isCanceled] == false - single (first) result will be emitted via [listener]
  /// Otherwise nothing will happen
  UseCaseSubscription callCancelable(
    Input input,
    Listener listener,
  ) {
    final useCaseSubscription = UseCaseSubscription();
    call(input).then((Output output) {
      if (useCaseSubscription.isCanceled) return;
      listener(output);
    });
    return useCaseSubscription;
  }

  /// Analog of [Stream.listen], but with much more limited capacities
  ///
  /// All errors should be handled inside [transaction].
  /// If you need return [Error], please use
  UseCaseSubscription listen(
    Input input,
    Listener<Output> listener,
  ) {
    final subscription = transaction(input).listen(listener);
    return UseCaseSubscription(subscription.cancel);
  }

  @protected
  String get logTag => runtimeType.toString();
}

class UseCaseSubscription {
  final Function? _cancelCallback;

  UseCaseSubscription([this._cancelCallback]);

  bool _isCanceled = false;

  bool get isCanceled => _isCanceled;

  Future<void> cancel() async {
    if (_isCanceled) return;
    _isCanceled = true;
    await _cancelCallback?.call();
  }
}

class UseCaseSubscriptionGroup {
  final List<UseCaseSubscription> _subscriptions = [];

  void add(UseCaseSubscription subscription) =>
      _subscriptions.add(subscription);

  bool get hasSubscriptions => _subscriptions.isNotEmpty;

  Future<void> cancel() async {
    for (final element in _subscriptions) {
      await element.cancel();
    }
  }
}
