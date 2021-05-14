import 'package:moody/platforms/platform.dart';
import 'package:path_provider/path_provider.dart';

class Android implements Platform {
  @override
  Future<String> getFileExportPath() async {
    return (await getExternalStorageDirectory())?.path ?? '';
  }
}
