import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/remote_configs.dart';
import 'package:mobile_app/domain/extensions/string.dart';
import 'package:mobile_app/domain/helper/email_sender.dart';
import 'package:mobile_app/domain/model/tale/tale.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/presentation/resource/r.dart';

@Injectable(as: UseCase)
class ReportTaleUseCase extends UseCase<Tale, ReportTaleOutput> {
  final EmailSender _emailSender;
  final RemoteConfigs _remoteConfigs;

  ReportTaleUseCase(
    this._remoteConfigs,
    this._emailSender,
  );

  @override
  Stream<ReportTaleOutput> transaction(Tale input) async* {
    final subject = StringSingleLine(
      R.strings.general.appName + R.strings.email.reportTale,
    );
    final body = R.strings.email.reportTaleDraft.format(input.id.get());
    _emailSender.send(
      recipient: _remoteConfigs.getDevEmail(),
      subject: subject,
      body: StringNonEmpty(body),
    );
    yield _unit;
  }
}

class ReportTaleOutput {
  const ReportTaleOutput._();
}

const _unit = ReportTaleOutput._();
