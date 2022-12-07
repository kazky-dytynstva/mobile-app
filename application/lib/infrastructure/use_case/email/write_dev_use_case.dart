import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/remote_configs.dart';
import 'package:mobile_app/domain/helper/email_sender.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/presentation/resource/r.dart';

@Injectable(as: UseCase)
class WriteDevUseCase extends UseCase<Dry, WriteDevOutput> {
  final EmailSender _emailSender;
  final RemoteConfigs _remoteConfigs;

  WriteDevUseCase(
    this._remoteConfigs,
    this._emailSender,
  );

  @override
  Stream<WriteDevOutput> transaction(Dry input) async* {
    final subject = StringSingleLine(
      R.strings.general.appName + R.strings.email.writeDevSubject,
    );
    _emailSender.send(
      recipient: _remoteConfigs.getDevEmail(),
      subject: subject,
      body: StringNonEmpty(R.strings.email.writeDevBodyDraft),
    );
    yield _unit;
  }
}

class WriteDevOutput {
  const WriteDevOutput._();
}

const _unit = WriteDevOutput._();
