import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app/infrastructure/data_source/storage_local/hive_adapter_ids.dart';
import 'package:mobile_app/infrastructure/di/module/storage.dart';

part 'person_entity.g.dart';

@HiveType(typeId: HiveAdapterIds.person)
//ignore: must_be_immutable
class PersonEntity extends Equatable {
  @HiveField(0)
  late DbKey id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  String? url;

  @HiveField(3)
  String? info;

  @HiveField(4)
  bool? isFavorite;

  /// used by [Hive]
  PersonEntity();

  PersonEntity.create({
    required this.id,
    required this.name,
    required this.url,
    required this.info,
    required this.isFavorite,
  });

  PersonEntity copy({
    String? name,
    String? url,
    String? info,
    bool? isFavorite,
  }) =>
      PersonEntity.create(
        id: id,
        name: name ?? this.name,
        url: url ?? this.url,
        info: info ?? this.info,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        url,
        info,
        isFavorite,
      ];
}
