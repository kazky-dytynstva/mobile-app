import 'package:mobile_app/data/data_source/storage_local/tale/entity/crew/crew_entity.dart';

final TaleCrewEntity crewNullable = getCrewEntity(
  authors: null,
  readers: null,
  musicians: null,
  translators: null,
  graphics: null,
);
final TaleCrewEntity crewIncremental = getCrewEntity(
  authors: [0, 1],
  readers: [2, 3],
  translators: [4, 5],
  musicians: [6, 7],
  graphics: [8, 9],
);
final TaleCrewEntity crewEmpty = getCrewEntity(
  authors: [],
  readers: [],
  musicians: [],
  translators: [],
  graphics: [],
);

TaleCrewEntity getCrewEntity({
  List<int>? authors,
  List<int>? readers,
  List<int>? translators,
  List<int>? musicians,
  List<int>? graphics,
}) =>
    TaleCrewEntity.create(
      authors: authors,
      readers: readers,
      translators: translators,
      musicians: musicians,
      graphics: graphics,
    );
