import 'package:hive/hive.dart';

part 'ImageFile.g.dart';

@HiveType(typeId: 1)
class ImageFile {
  @HiveField(0)
  int id;

  @HiveField(1)
  String imageFilePath;

  @HiveField(2)
  bool isUploadPending;

  ImageFile(this.id, this.imageFilePath, this.isUploadPending);
}
