// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:habit_tracker/domain/models/app_settings.dart';
import 'package:habit_tracker/domain/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  // INITIALIZE DATABASE
  static late Isar isar;
  static Future<void> initializate() async {
    final dir = await getApplicationSupportDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  //SAVE THE FIRST DATE OF APP STARTUP
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  //GET FIRST DATE OF APP STARTUP
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  //CRUD OPERATIONS

  //List of habits
  final List<Habit> currentHabits = [];

  // CREATE - Add a new habit
  Future<void> addHabit(String habitName) async {
    // create a new habit
    final newHabit = Habit()..name = habitName;

    // save to Db
    await isar.writeTxn(() => isar.habits.put(newHabit));

    // re-read from from Db to get the latest information
    readHabits();
  }

  // READ - Read habits from Db
  Future<void> readHabits() async {
    // fetch all habits from fb
    List<Habit> fetchhabits = await isar.habits.where().findAll();

    // save to the currentHabits list
    currentHabits.clear();
    currentHabits.addAll(fetchhabits);

    // update ui
    notifyListeners();
  }

  //UPDATE - Update the habit name
  Future<void> updateHabitName(int id, String newName) async {
    // find the habit by id
    final habit = await isar.habits.get(id);

    // update habit name
    if (habit != null) {
      await isar.writeTxn(() async {
        habit.name = newName;

        //save to Db
        await isar.habits.put(habit);
      });
    }

    // re-read from Db
    readHabits();
  }

  // UPDATE - Change the completion status of the habit
  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    //find the habit by id
    final habit = await isar.habits.get(id);

    //update completion status
    if (habit != null) {
      await isar.writeTxn(() async {
        // if habit is completed -> add to the current date to the completedDays list
        if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
          //today
          final today = DateTime.now();

          // add the current date if it's not already in the list
          habit.completedDays.add(
            DateTime(
              today.year,
              today.month,
              today.day,
            ),
          );

          // if habit is NOT completed -> remove the current date from the completedDays list
        } else {
          // remove the current date if the habit is marked as not completed
          habit.completedDays.removeWhere(
            (date) =>
                date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day,
          );
        }

        // save the updated habits back to the Db
        await isar.habits.put(habit);
      });
    }

    // re-read from Db
    readHabits();
  }

  // DELETE - Delete the habit from db
  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });

    // re-read from Db
    readHabits();
  }
}
