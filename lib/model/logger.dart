import 'package:isar/isar.dart';

import 'counter.dart';

part 'logger.g.dart';

@collection
class Logger {
  Id id = Isar.autoIncrement;
  IsarLink<Counter> counter = IsarLink<Counter>();
  @enumerated
  CounterType type;
  DateTime date = DateTime.now();

  Logger({
    this.type = CounterType.increment,
  });
}
