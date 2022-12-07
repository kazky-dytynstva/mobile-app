import 'package:dartz/dartz.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/domain/value_objects/string_single_line.dart';

abstract class EmailSender {
  Future<Unit> send({
    required StringSingleLine recipient,
    required StringSingleLine subject,
    required StringNonEmpty body,
  });
}
