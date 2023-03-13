abstract class EnvConfig {
  EnvConfig._();

  static const String staging = String.fromEnvironment('DF_STAGE_NAME');
  static const String appBundle = String.fromEnvironment('DF_APP_ID');

  static const bool isProd = staging == Stagings.prod;
  static const bool isInternal = staging == Stagings.internal;
  static const bool isDebug = staging == Stagings.dev;

  static void validateStaging() {
    assert(staging == Stagings.prod ||
        staging == Stagings.internal ||
        staging == Stagings.dev);
  }
}

abstract class Stagings {
  Stagings._();

  static const String prod = "prod";
  static const String internal = "internal";
  static const String dev = "dev";
}
