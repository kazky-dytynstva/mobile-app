abstract class Logger {
  void log(
    String Function() msg, {
    String? tag,
    bool toCrashAnalytics = false,
  });
}
