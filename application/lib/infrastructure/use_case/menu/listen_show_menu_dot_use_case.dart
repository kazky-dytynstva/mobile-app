import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/feature_flag/feature.dart';
import 'package:mobile_app/domain/feature_flag/feature_flag_provider.dart';
import 'package:mobile_app/domain/model/show_dot/show_dot_type.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:stream_transform/stream_transform.dart';

@Injectable(as: UseCase)
class ListenShowMenuDotUseCase extends UseCase<Dry, ListenShowMenuDotOutput> {
  final AppStateStorage _stateStorage;
  final FeatureFlagProvider _featureFlagProvider;

  ListenShowMenuDotUseCase(
    this._stateStorage,
    this._featureFlagProvider,
  );

  @override
  Stream<ListenShowMenuDotOutput> transaction(Dry input) async* {
    final output = await _getOutput();
    yield output;

    final streamTransformer = StreamTransformer.fromHandlers(
      handleData: (bool show, EventSink<ListenShowMenuDotOutput> sink) async {
        final output = await _getOutput();
        sink.add(output);
      },
    );

    yield* _stateStorage
        .watchShowDotForType(ShowDotType.donation)
        .merge(_stateStorage.watchShowDotForType(ShowDotType.whatsNew))
        .transform(streamTransformer);
  }

  Future<ListenShowMenuDotOutput> _getOutput() async {
    var showDonation = (_featureFlagProvider.isEnabled(Feature.donation) &&
        await _stateStorage.showDotForType(ShowDotType.donation));
    var showWhatsNews =
        await _stateStorage.showDotForType(ShowDotType.whatsNew);

    return ListenShowMenuDotOutput(showWhatsNews || showDonation);
  }
}

@immutable
class ListenShowMenuDotOutput {
  final bool showDot;

  const ListenShowMenuDotOutput(this.showDot);
}
