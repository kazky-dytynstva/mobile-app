import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/remote_configs.dart';
import 'package:mobile_app/domain/extensions/string.dart';
import 'package:mobile_app/domain/helper/share_helper.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/presentation/resource/r.dart';

@Injectable(as: UseCase)
class ShareAppUseCase extends UseCase<Dry, ShareAppOutput> {
  final ShareHelper _shareHelper;
  final RemoteConfigs _remoteConfigs;

  ShareAppUseCase(
    this._shareHelper,
    this._remoteConfigs,
  );

  @override
  Stream<ShareAppOutput> transaction(Dry input) async* {
    final appLink = _remoteConfigs.shareAppLink().get();
    final text = R.strings.general.shareApp.format(appLink);

    await _shareHelper.text(text: StringNonEmpty(text));

    yield _unit;
  }
}

class ShareAppOutput {
  const ShareAppOutput._();
}

const _unit = ShareAppOutput._();
