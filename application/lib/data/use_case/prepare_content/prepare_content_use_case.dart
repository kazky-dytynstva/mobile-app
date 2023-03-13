import 'package:dartz/dartz.dart';
import 'package:collection/collection.dart';
import 'package:dto/dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_app/domain/failure/network_request_failure.dart';
import 'package:mobile_app/domain/mapper/mapper.dart';
import 'package:mobile_app/domain/model/person/value_objects/person_id.dart';
import 'package:mobile_app/domain/model/tale/value_object/tale_id.dart';
import 'package:mobile_app/domain/repository/people_repository.dart';
import 'package:mobile_app/domain/use_case/usecase.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';
import 'package:mobile_app/data/data_source/remote_api/base/api_client.dart';
import 'package:mobile_app/domain/data_source/storage_local/app_state_storage.dart';
import 'package:mobile_app/data/data_source/storage_local/people/entity/person_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/people_storage.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/rating/rating_entity.dart';
import 'package:mobile_app/data/data_source/storage_local/tale/entity/tale_entity.dart';
import 'package:mobile_app/domain/data_source/storage_local/tale_storage.dart';
import 'package:mobile_app/data/env_config/env_config.dart';
import 'package:mobile_app/data/helper/logger/logger.dart';
import 'package:mobile_app/presentation/resource/r.dart';

part 'prepare_content_use_case.freezed.dart';

const _updateContentThreshold = Duration(hours: 1);
const _updateContentThresholdDev = Duration(seconds: 5);

@Injectable(as: UseCase)
class PrepareContentUseCase
    extends UseCase<PrepareContentInput, PrepareContentOutput> {
  final PeopleStorage _peopleStorage;
  final TaleStorage _taleStorage;
  final AppStateStorage _appStateStorage;
  final PeopleRepository _peopleRepository;
  final ApiClient _apiClient;

  final Mapper<PersonDto, PersonEntity> _personMapper;
  final Mapper<RatingDto, RatingEntity> _ratingMapper;
  final Mapper<TaleDto, TaleEntity> _taleMapper;
  final Logger _logger;

  PrepareContentUseCase(
    this._peopleStorage,
    this._appStateStorage,
    this._taleStorage,
    this._peopleRepository,
    this._apiClient,
    this._personMapper,
    this._taleMapper,
    this._ratingMapper,
    this._logger,
  );

  Future<bool> get _needPreloadContent async => (await Future.wait([
        _taleStorage.isEmpty(),
        _peopleStorage.isEmpty(),
      ]))
          .any((isEmpty) => isEmpty);

  @override
  Stream<PrepareContentOutput> transaction(PrepareContentInput input) async* {
    _logger.log(
      () => 'Prepare content useCase called',
      tag: logTag,
    );
    if (await _needPreloadContent) {
      _logger.log(
        () => 'need preload all content',
        tag: logTag,
      );
      final option = await _preloadContent();
      if (option.isSome()) {
        yield* Stream.value((option as Some).value);
        return;
      }
    } else if (await _lastUpdateWasLongTimeAgo()) {
      _logger.log(
        () => 'silent preload all content (update)',
        tag: logTag,
      );
      _preloadContent();
    } else {
      _logger.log(
        () => 'update all content skipped',
        tag: logTag,
      );
    }

    await _peopleRepository.prepare(!input.silent);

    yield* Stream.value(const PrepareContentOutput.success(unit));
  }

  Future<bool> _lastUpdateWasLongTimeAgo() async {
    final lastUpdateDate = await _appStateStorage.getLastContentUpdateDate();
    final now = DateTime.now();
    const updateThreshold =
        EnvConfig.isProd ? _updateContentThreshold : _updateContentThresholdDev;
    final boll = lastUpdateDate.add(updateThreshold).isBefore(now);
    return boll;
  }

  /// return [None], if operation successful
  /// return [Some], if error occur
  Future<Option<PrepareContentOutput>> _preloadContent() async {
    final List<Either<NetworkRequestFailure, Iterable<Object>>> result =
        await Future.wait([
      _apiClient.getPeople(),
      _apiClient.getTales(),
      _apiClient.getRatings(),
    ]);
    final failure = result.firstWhereOrNull((it) => it.isLeft());
    if (failure != null) {
      final networkFailure = (failure as Left).value as NetworkRequestFailure;

      return Some(_handleRequestFailure(networkFailure));
    }

    for (final either in result) {
      final rightValue = (either as Right).value as Iterable;
      final first = rightValue.first;
      switch (first.runtimeType) {
        case TaleDto:
          await _storeTales(rightValue as Iterable<TaleDto>);
          break;
        case RatingDto:
          await _storeRatings(rightValue as Iterable<RatingDto>);
          break;
        case PersonDto:
          await _storePeople(rightValue as Iterable<PersonDto>);
          break;
      }
    }

    await _appStateStorage.setLastContentUpdateDate(DateTime.now());
    return const None();
  }

  PrepareContentOutput _handleRequestFailure(NetworkRequestFailure failure) {
    final error = failure.map(
      noInternet: (_) => R.strings.splash.getInitialContentFailed.noInternet,
      notAuthorized: (_) =>
          R.strings.splash.getInitialContentFailed.serverError,
      serverError: (_) => R.strings.splash.getInitialContentFailed.serverError,
      responseParseError: (_) =>
          R.strings.splash.getInitialContentFailed.parsingError,
      unknownError: (_) =>
          R.strings.splash.getInitialContentFailed.unknownError,
    );
    return PrepareContentOutput.failure(StringNonEmpty(error));
  }

  Future<Unit> _storeTales(Iterable<TaleDto> tales) async {
    final entities = tales.map(_taleMapper.map);
    await _taleStorage.updateTales(entities);
    await _removeDeletedTales(tales);
    return unit;
  }

  Future<Unit> _storeRatings(Iterable<RatingDto> ratings) async {
    final entities = <TaleId, RatingEntity>{};
    for (final item in ratings) {
      final entity = _ratingMapper.map(item);
      entities[TaleId(item.taleId)] = entity;
    }
    await _taleStorage.updateRatings(entities);
    return unit;
  }

  Future<Unit> _storePeople(Iterable<PersonDto> people) async {
    final entities = people.map(_personMapper.map);
    await _peopleStorage.updatePeople(entities);
    await _removeDeletedPeople(people);
    return unit;
  }

  Future<Unit> _removeDeletedTales(Iterable<TaleDto> newList) async {
    final storedIds = (await _taleStorage.getAll()).map((e) => e.id).toList();
    final newIds = newList.map((e) => e.id).toList();
    storedIds.removeWhere((id) => newIds.contains(id));
    if (storedIds.isNotEmpty) {
      await _taleStorage.deleteTales(storedIds.map((e) => TaleId(e)));
    }
    return unit;
  }

  Future<Unit> _removeDeletedPeople(Iterable<PersonDto> newList) async {
    final storedIds =
        (await _peopleStorage.getPeople()).map((e) => e.id).toList();
    final newIds = newList.map((e) => e.id).toList();
    storedIds.removeWhere((id) => newIds.contains(id));
    if (storedIds.isNotEmpty) {
      await _peopleStorage.deletePeople(storedIds.map((e) => PersonId(e)));
    }
    return unit;
  }
}

class PrepareContentInput {
  final bool silent;

  const PrepareContentInput({required this.silent});
}

@Freezed(
  map: FreezedMapOptions(maybeMap: false),
  when: FreezedWhenOptions(maybeWhen: false),
)
abstract class PrepareContentOutput with _$PrepareContentOutput {
  const PrepareContentOutput._();

  const factory PrepareContentOutput.success(Unit unit) = _Data;

  const factory PrepareContentOutput.failure(StringNonEmpty error) = _Failure;
}
