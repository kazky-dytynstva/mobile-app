import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/user_action/user_action_request.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';

@Injectable(as: UseCase)
class GetUserActionRequestUseCase extends UseCase<Dry, UserActionRequest?> {
  @override
  Stream<UserActionRequest?> transaction(Dry input) async* {
    yield const UserActionRequest.rate();
  }
}
