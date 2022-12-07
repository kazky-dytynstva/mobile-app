import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/helper/email_sender.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';

import 'package:flutter_email_sender/flutter_email_sender.dart';

@LazySingleton(as: EmailSender)
class EmailSenderImpl implements EmailSender {
  @override
  Future<Unit> send({
    required StringSingleLine recipient,
    required StringSingleLine subject,
    required StringNonEmpty body,
  }) async {
    final email = Email(
      body: body.get(),
      subject: subject.get(),
      recipients: [recipient.get()],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
    return unit;
  }
}
