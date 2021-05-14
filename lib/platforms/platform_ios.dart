import 'package:moody/platforms/platform.dart';
import 'package:path_provider/path_provider.dart';

class IOS implements Platform {
  @override
  Future<String> getFileExportPath() async {
    return (await getApplicationDocumentsDirectory()).path;
  }
}
