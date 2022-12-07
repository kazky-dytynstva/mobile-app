import 'package:equatable/equatable.dart';
import 'package:mobile_app/domain/value_objects/int_positive.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/infrastructure/env_config/env_config.dart';

class AppVersion extends Equatable {
  final StringSingleLine name;
  final IntPositive code;
  final StringSingleLine staging;

  const AppVersion({
    required this.name,
    required this.code,
    required this.staging,
  });

  @override
  List<Object> get props => [];

  String get pretty {
    final base = '${name.get()} (${code.get()})';
    if (EnvConfig.isProd) return base;
    return '$base - ${staging.get()}';
  }
}
