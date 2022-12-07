import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/show_dot/show_dot_type.dart';

const _donation = 'donation';
const _whatsNew = 'whatsNew';
const _unknown = 'unknown';

@Singleton(as: Mapper)
class ShowDotTypeToDbKeyMapper implements Mapper<ShowDotType, String> {
  @override
  String map(ShowDotType input) {
    switch (input) {
      case ShowDotType.donation:
        return _donation;
      case ShowDotType.whatsNew:
        return _whatsNew;
      case ShowDotType.unknown:
        return _unknown;
    }
  }
}
