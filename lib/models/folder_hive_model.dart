import 'package:hive/hive.dart';

part 'folder_hive_model.g.dart';

@HiveType(typeId: 1)
class FolderModel extends HiveObject {
  @HiveField(0)
  String folderTitle;

  @HiveField(1)
  String folderSubTitle;

  @HiveField(2)
  String folderImage;

  @HiveField(3)
  double price;

  @HiveField(4)
  String note;

  FolderModel({
    required this.folderTitle,
    required this.folderSubTitle,
    required this.folderImage,
    required this.price,
    required this.note,
  });
}
