import 'package:dartz/dartz.dart';

abstract class AppUpdateHelper {
  Future<bool> hasUpdates();

  Future<Unit> openStore();
}
