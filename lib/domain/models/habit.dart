import 'package:isar/isar.dart';

part 'habit.g.dart';

@Collection()
class Habit {
  Id id = Isar.autoIncrement;

  late String name;

  List<DateTime> completedDays = [];
  //Datetime(year, month , day)
  //Datetime(2024,  02, 29)
}
