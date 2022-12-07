import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/infrastructure/helper/logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

@Injectable(as: UseCase)
class OpenUrlUseCase extends UseCase<UrlString, OpenUrlOutput> {
  final Logger _logger;

  OpenUrlUseCase(
    this._logger,
  );

  @override
  Stream<OpenUrlOutput> transaction(UrlString input) async* {
    _logger.log(
      () => 'requested to open url',
      tag: logTag,
    );
    final result = await launchUrl(input.asUri);
    _logger.log(
      () => 'url opened successfully: $result',
      tag: logTag,
    );
    yield _output;
  }
}

class OpenUrlOutput {
  @visibleForTesting
  const OpenUrlOutput();
}

const _output = OpenUrlOutput();
