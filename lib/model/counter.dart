import 'package:counter_plus_plus/model/logger.dart';
import 'package:isar/isar.dart';

part 'counter.g.dart';

@collection
class Counter {
  Id id = Isar.autoIncrement;
  String name;
  int count = 0;
  bool hidden = false;
  @Backlink(to: "counter")
  IsarLinks<Logger> loggers = IsarLinks<Logger>();

  Counter({
    required this.name,
  });
}

enum CounterType { increment, decrement }
