// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeopleAdapter extends TypeAdapter<People> {
  @override
  final int typeId = 0;

  @override
  People read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return People()
      ..uuid = fields[0] as String
      ..name = fields[1] as String
      ..dateTime = fields[2] as DateTime
      ..location = fields[3] as String
      ..gender = fields[4] as String
      ..general = (fields[5] as Map).cast<String, dynamic>()
      ..economy = (fields[6] as Map).cast<String, dynamic>()
      ..education = (fields[7] as Map).cast<String, dynamic>()
      ..governmentSchemes = (fields[8] as Map).cast<String, dynamic>()
      ..health = (fields[9] as Map).cast<String, dynamic>()
      ..modernization = (fields[10] as Map).cast<String, dynamic>()
      ..social = (fields[11] as Map).cast<String, dynamic>();
  }

  @override
  void write(BinaryWriter writer, People obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.general)
      ..writeByte(6)
      ..write(obj.economy)
      ..writeByte(7)
      ..write(obj.education)
      ..writeByte(8)
      ..write(obj.governmentSchemes)
      ..writeByte(9)
      ..write(obj.health)
      ..writeByte(10)
      ..write(obj.modernization)
      ..writeByte(11)
      ..write(obj.social);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeopleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
