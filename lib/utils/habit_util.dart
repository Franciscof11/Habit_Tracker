// Given an habit list of completion days
// Is the habit completed today
import '../domain/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();

  return completedDays.any(
    (date) =>
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day,
  );
}

// prepare heat map dataset
Map<DateTime, int> prepareMapDataset(List<Habit> habits) {
  Map<DateTime, int> dataset = {};

  for (var habit in habits) {
    for (var date in habit.completedDays) {
      final normalizeDate = DateTime(
        date.year,
        date.month,
        date.day,
      );

      if (dataset.containsKey(normalizeDate)) {
        dataset[normalizeDate] = dataset[normalizeDate]! + 1;
      } else {
        dataset[normalizeDate] = 1;
      }
    }
  }

  return dataset;
}
