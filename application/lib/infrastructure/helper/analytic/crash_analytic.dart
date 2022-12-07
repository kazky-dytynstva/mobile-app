abstract class CrashAnalytic {
  void setEnable(bool enable);

  void setKey({
    required String key,
    required String value,
  });

  void msg(String msg);

  void exception(
    dynamic exception,
    StackTrace trace, {
    bool fatal = false,
  });

  void setUserId(String identifier);
}
