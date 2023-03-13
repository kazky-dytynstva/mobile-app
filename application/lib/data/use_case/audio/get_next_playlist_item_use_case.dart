import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/model/player/playlist_data.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/data/helper/player/audio_player.dart';

@Injectable(as: UseCase)
class GetNextPlaylistItemUseCase
    extends UseCase<Dry, Option<PlaylistItemData>> {
  final AudioPlayer _player;

  GetNextPlaylistItemUseCase(
    this._player,
  );

  @override
  Stream<Option<PlaylistItemData>> transaction(Dry input) async* {
    final nextItem = _player.getNextPlaylistItem();
    if (nextItem == null) {
      yield const None();
    } else {
      yield Some(nextItem);
    }
  }
}
