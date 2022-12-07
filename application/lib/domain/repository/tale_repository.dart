import 'package:mobile_app/domain/model/tale/tale.dart';

abstract class TaleRepository {
  void setCurrentTale(Tale tale);

  Stream<Tale> watchCurrentTaleChange();
}
