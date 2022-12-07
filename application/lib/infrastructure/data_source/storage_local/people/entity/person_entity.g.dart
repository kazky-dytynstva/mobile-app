// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonEntityAdapter extends TypeAdapter<PersonEntity> {
  @override
  final int typeId = 1;

  @override
  PersonEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonEntity()
      ..id = fields[0] as int
      ..name = fields[1] as String
      ..url = fields[2] as String?
      ..info = fields[3] as String?
      ..isFavorite = fields[4] as bool?;
  }

  @override
  void write(BinaryWriter writer, PersonEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.info)
      ..writeByte(4)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
