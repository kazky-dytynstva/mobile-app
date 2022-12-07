import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/data_source/remote_configs.dart';
import 'package:mobile_app/domain/helper/email_sender.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';
import 'package:mobile_app/presentation/resource/r.dart';

@Injectable(as: UseCase)
class AddTaleUseCase extends UseCase<Dry, AddTaleOutput> {
  final EmailSender _emailSender;
  final RemoteConfigs _remoteConfigs;

  AddTaleUseCase(
    this._remoteConfigs,
    this._emailSender,
  );

  @override
  Stream<AddTaleOutput> transaction(Dry input) async* {
    final subject = StringSingleLine(
      R.strings.general.appName + R.strings.email.addTaleSubject,
    );
    _emailSender.send(
      recipient: _remoteConfigs.getDevEmail(),
      subject: subject,
      body: StringNonEmpty(R.strings.email.addTaleBodyDraft),
    );
    yield _unit;
  }
}

class AddTaleOutput {
  const AddTaleOutput._();
}

const _unit = AddTaleOutput._();
