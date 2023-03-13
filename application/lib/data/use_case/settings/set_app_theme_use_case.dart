import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/storage_local/settings_storage.dart';
import 'package:mobile_app/domain/model/app_theme/app_theme.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';

@Injectable(as: UseCase)
class SetAppThemeUseCase extends UseCase<AppTheme, Dry> {
  final SettingsStorage _storage;

  SetAppThemeUseCase(this._storage);

  @override
  Stream<Dry> transaction(AppTheme input) async* {
    await _storage.setAppTheme(input);
    yield dry;
  }
}
