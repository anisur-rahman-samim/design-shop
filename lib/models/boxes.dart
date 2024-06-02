import 'package:hive/hive.dart';
import 'package:shop/models/folder_hive_model.dart';

import 'hive_model.dart';

class Boxes {
  static Box<NotesModel> getData() => Hive.box('database');
  static Box<FolderModel> getFolderData() => Hive.box('folder');
}
