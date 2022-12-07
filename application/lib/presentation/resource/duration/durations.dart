part of '../r.dart';

class Durations {
  Durations._();

  Duration get animShort => const Duration(milliseconds: 200);

  Duration get animMiddle => const Duration(milliseconds: 400);

  Duration get animLong => const Duration(milliseconds: 600);

  Duration get updateTaleListDebounce => const Duration(milliseconds: 100);

  Duration get showHiddenScrolledWidget => const Duration(milliseconds: 2000);

  Duration get updateTaleLastPositionDebounce =>
      const Duration(milliseconds: 300);

  Duration get hideScrollToTopBtnTimeout => const Duration(seconds: 10);

  Duration get markTaleWatchedTimeOut => const Duration(seconds: 5);
}
