import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import '../../objectbox.g.dart';


class ObjectBoxSingleton {
  static final ObjectBoxSingleton _singleton = ObjectBoxSingleton._internal();

  factory ObjectBoxSingleton() => _singleton;

  ObjectBoxSingleton._internal();

  late Store _store;

  Store get store => _store;

  Future<void> initObjectBox() async {
    final docsDir = await getApplicationDocumentsDirectory();
    _store = await openStore(directory: p.join(docsDir.path, "link-database"));
  }

  void closeObjectBox() {
    _store.close();
  }
}