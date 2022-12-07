import 'package:equatable/equatable.dart';
import 'package:mobile_app/domain/model/app_version/app_version.dart';
import 'package:mobile_app/domain/value_objects/string_not_empty.dart';

class VersionChanges extends Equatable {
  final AppVersion version;
  final List<VersionChangeItem> items;

  const VersionChanges(
    this.version,
    this.items,
  ) : assert(items.length > 0);

  @override
  List<Object> get props => [
        version,
      ];
}

class VersionChangeItem extends Equatable {
  final StringNonEmpty title;
  final StringNonEmpty? description;

  const VersionChangeItem({
    required this.title,
    this.description,
  });

  @override
  List<Object?> get props => [
        title,
        description,
      ];
}
