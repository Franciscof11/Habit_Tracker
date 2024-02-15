import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class HabitListTile extends StatelessWidget {
  final String habitName;
  final bool isCompleted;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;
  final void Function(bool?)? onChanged;
  const HabitListTile({
    super.key,
    required this.habitName,
    required this.isCompleted,
    required this.onChanged,
    required this.editHabit,
    required this.deleteHabit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            // Edit Option
            SlidableAction(
              onPressed: editHabit,
              backgroundColor: Colors.grey.shade800,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(8),
            ),

            // Delete Option
            SlidableAction(
              onPressed: deleteHabit,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (onChanged != null) {
              onChanged!(!isCompleted);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: isCompleted
                  ? Colors.green
                  : Theme.of(context).colorScheme.secondary,
            ),
            child: ListTile(
              title: Text(
                habitName,
                style: GoogleFonts.inter(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              trailing: Checkbox(
                activeColor: Theme.of(context).colorScheme.inversePrimary,
                value: isCompleted,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
