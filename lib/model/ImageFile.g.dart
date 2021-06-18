// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ImageFile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageFileAdapter extends TypeAdapter<ImageFile> {
  @override
  final int typeId = 1;

  @override
  ImageFile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageFile(
      fields[0] as int,
      fields[1] as String,
      fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ImageFile obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageFilePath)
      ..writeByte(2)
      ..write(obj.isUploadPending);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageFileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
