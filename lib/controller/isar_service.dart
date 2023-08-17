import 'package:counter_plus_plus/model/logger.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../model/counter.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> saveCounter(Counter counter) async {
    final isar = await db;
    isar.writeTxnSync<int>(
      () => isar.counters.putSync(counter),
    );
  }

  Future<void> incrementCounter(Counter counter) async {
    final isar = await db;
    counter.count += 1;
    isar.writeTxnSync<int>(
      () => isar.counters.putSync(counter),
    );
    Logger logger = Logger()..counter.value = counter;
    isar.writeTxnSync<int>(
      () => isar.loggers.putSync(logger),
    );
  }

  Future<void> decrementCounter(Counter counter) async {
    final isar = await db;
    counter.count -= 1;
    isar.writeTxnSync<int>(
      () => isar.counters.putSync(counter),
    );
    Logger logger = Logger(type: CounterType.decrement)
      ..counter.value = counter;
    isar.writeTxnSync<int>(
      () => isar.loggers.putSync(logger),
    );
  }

  Stream<List<Counter>> counterStream() async* {
    final isar = await db;
    yield* isar.counters.where().watch(fireImmediately: true);
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [CounterSchema],
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
