import 'package:injectable/injectable.dart';
import 'package:mobile_app/data/use_case/helper/open_url_use_case.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/domain/model/menu_dynamic_item/menu_dynamic_item_data.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/url_string.dart';
import 'package:mobile_app/presentation/navigation/screen/screen_controller.dart';

@Injectable(as: UseCase)
class OnDynamicItemClickedUseCase extends UseCase<MenuDynamicItemData, Dry> {
  final AppStateStorage _stateStorage;
  final ScreenController _screenController;
  final UseCase<UrlString, OpenUrlOutput> _openUrlUseCase;

  OnDynamicItemClickedUseCase(
    this._stateStorage,
    this._screenController,
    this._openUrlUseCase,
  );

  @override
  Stream<Dry> transaction(MenuDynamicItemData input) async* {
    await _stateStorage.setLastSeenMenuDynamicDataId(input.id);

    if (input.needToOpenScreen) {
      _screenController.openDynamicItem(input);
    } else {
      _openUrlUseCase.call(input.url);
    }

    yield dry;
  }
}
