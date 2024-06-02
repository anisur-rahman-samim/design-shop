// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FolderModelAdapter extends TypeAdapter<FolderModel> {
  @override
  final int typeId = 1;

  @override
  FolderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FolderModel(
      folderTitle: fields[0] as String,
      folderSubTitle: fields[1] as String,
      folderImage: fields[2] as String,
      price: fields[3] as double,
      note: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FolderModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.folderTitle)
      ..writeByte(1)
      ..write(obj.folderSubTitle)
      ..writeByte(2)
      ..write(obj.folderImage)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FolderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
