import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop/helpers/share_pref_helper.dart';
import 'package:shop/models/folder_hive_model.dart';
import 'package:shop/models/hive_model.dart';
import 'package:shop/views/widgets/bottom_nav_bar.dart';
import 'themes/theme_light.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharePrefHelper.getSharePrefData();

  var directory = await getApplicationCacheDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModelAdapter());
  Hive.registerAdapter(FolderModelAdapter());

  await Hive.openBox<NotesModel>('database');
  await Hive.openBox<FolderModel>('folder');

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(ImageModelAdapter());
  await Hive.openBox<ImageModel>('images');


  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return GetMaterialApp(
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: BottomNavBar());
      },
    );
  }
}

@HiveType(typeId: 3)
class ImageModel extends HiveObject {
  @HiveField(0)
  String imagePath;

  @HiveField(1)
  String folderName;

  @HiveField(2)
  String note;

  ImageModel(this.imagePath, this.folderName, this.note);
}

class ImageModelAdapter extends TypeAdapter<ImageModel> {
  @override
  final typeId = 3;

  @override
  ImageModel read(BinaryReader reader) {
    return ImageModel(
      reader.readString(),
      reader.readString(),
      reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ImageModel obj) {
    writer.writeString(obj.imagePath);
    writer.writeString(obj.folderName);
    writer.writeString(obj.note);
  }
}