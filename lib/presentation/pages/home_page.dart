import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/domain/database/habit_database.dart';
import 'package:habit_tracker/presentation/widgets/drawer_home.dart';
import 'package:habit_tracker/presentation/widgets/habit_list_tile.dart';
import 'package:habit_tracker/presentation/widgets/my_heat_map.dart';
import 'package:habit_tracker/utils/habit_util.dart';
import 'package:provider/provider.dart';

import '../../domain/models/habit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    //read the existing habits on app startUp
    Provider.of<HabitDatabase>(context, listen: false).readHabits();

    super.initState();
  }

  final habitNameController = TextEditingController();

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
          child: TextField(
            controller: habitNameController,
            decoration: InputDecoration(
              hintText: 'Habit name',
              hintStyle:
                  GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 17),
            ),
          ),
        ),
        actions: [
          // Cancel Button
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              habitNameController.clear();
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(),
            ),
          ),

          // Save Button
          MaterialButton(
            onPressed: () {
              String newHabitName = habitNameController.text;

              context.read<HabitDatabase>().addHabit(newHabitName);

              Navigator.pop(context);

              habitNameController.clear();
            },
            child: Text(
              'Save',
              style: GoogleFonts.inter(),
            ),
          ),
        ],
      ),
    );
  }

  void checkHabitOnOff(bool? value, Habit habit) {
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  void editHabit(Habit habit) {
    habitNameController.text = habit.name;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: habitNameController,
        ),
        actions: [
          // Cancel Button
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              habitNameController.clear();
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(),
            ),
          ),

          // Save Button
          MaterialButton(
            onPressed: () {
              String newHabitName = habitNameController.text;

              context
                  .read<HabitDatabase>()
                  .updateHabitName(habit.id, newHabitName);

              Navigator.pop(context);

              habitNameController.clear();
            },
            child: Text(
              'Save',
              style: GoogleFonts.inter(),
            ),
          ),
        ],
      ),
    );
  }

  void deleteHabit(Habit habit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to delete?'),
        actions: [
          // Cancel Button
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(),
            ),
          ),

          // Save Button
          MaterialButton(
            onPressed: () {
              context.read<HabitDatabase>().deleteHabit(habit.id);

              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: GoogleFonts.inter(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeatMap() {
    //habit DB
    final habitDB = context.read<HabitDatabase>();

    //get habit list
    List<Habit> currentHabits = habitDB.currentHabits;

    //return heatMap ui
    return FutureBuilder<DateTime?>(
      future: habitDB.getFirstLaunchDate(),
      builder: (context, snapshot) {
        // if data is available -> build heatMap
        if (snapshot.hasData) {
          return MyHeatMap(
            startDate: snapshot.data!,
            datasets: prepareMapDataset(currentHabits),
          );
        }

        // Case where no data is returned
        else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const DrawerHome(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 30),
        child: FloatingActionButton(
          onPressed: () => createNewHabit(),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            buildHeatMap(),
            const SizedBox(height: 15),
            SizedBox(
              height: 400,
              child: habitList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget habitList() {
    final habitDB = context.watch<HabitDatabase>();

    List<Habit> currentHabits = habitDB.currentHabits;

    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: currentHabits.length,
      itemBuilder: (current, index) {
        // Get each habit
        final habit = currentHabits[index];

        // check if is completed today
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

        //return habit tile UI
        return HabitListTile(
          habitName: habit.name,
          isCompleted: isCompletedToday,
          onChanged: (value) {
            checkHabitOnOff(value, habit);
          },
          editHabit: (context) => editHabit(habit),
          deleteHabit: (context) => deleteHabit(habit),
        );
      },
    );
  }
}
