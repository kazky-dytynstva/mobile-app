import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/settings_storage.dart';
import 'package:mobile_app/domain/model/settings/text_scale_factor.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';

@Injectable(as: UseCase)
class SetTextScaleFactorUseCase extends UseCase<TextScaleFactor, Dry> {
  final SettingsStorage _storage;

  SetTextScaleFactorUseCase(this._storage);

  @override
  Stream<Dry> transaction(TextScaleFactor input) async* {
    await _storage.setTextScaleFactor(input);
    yield dry;
  }
}
