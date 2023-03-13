import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'dependency_injection.config.dart';

final _locator = GetIt.instance;

T getIt<T extends Object>([String? instanceName]) =>
    _locator.get<T>(instanceName: instanceName);

/// [stageName] - is one from [StageNames]
@InjectableInit(generateForDir: [''])
Future<void> configureInjection(String stageName) async =>
    _locator.init(environment: stageName);
