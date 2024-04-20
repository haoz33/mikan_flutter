// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aria_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AriaConfigAdapter extends TypeAdapter<AriaConfig> {
  @override
  final int typeId = 13;

  @override
  AriaConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AriaConfig(
      domain: fields[0] as String,
      downloadPath: fields[5] as String,
      rpcPath: fields[2] as String,
      port: fields[1] as String,
      scheme: fields[3] as String,
      useBangumiPathName: fields[6] as bool,
      secret: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AriaConfig obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.domain)
      ..writeByte(1)
      ..write(obj.port)
      ..writeByte(2)
      ..write(obj.rpcPath)
      ..writeByte(3)
      ..write(obj.scheme)
      ..writeByte(4)
      ..write(obj.secret)
      ..writeByte(5)
      ..write(obj.downloadPath)
      ..writeByte(6)
      ..write(obj.useBangumiPathName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AriaConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
