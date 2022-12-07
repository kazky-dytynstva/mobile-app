import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/repository/tale_repository.dart';

@LazySingleton(as: TaleRepository)
class TaleRepositoryImpl implements TaleRepository {
  // Option<Tale> _currentTale = const None();
  final _taleChangeWatcherList = List<StreamController<Tale>>.empty();

  @override
  void setCurrentTale(Tale tale) {
    // _currentTale = Some(tale);
    for (final element in _taleChangeWatcherList) {
      element.add(tale);
    }
  }

  @override
  Stream<Tale> watchCurrentTaleChange() {
    late final StreamController<Tale> controller;
    controller = StreamController(
      onCancel: () {
        _taleChangeWatcherList.remove(controller);
      },
    );
    _taleChangeWatcherList.add(controller);

    return controller.stream;
  }
}
