// planer_tile.dart

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PlanerTile extends StatelessWidget {
  final String taskName;
  final DateTime taskDate;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunc;

  PlanerTile({
    super.key,
    required this.taskName,
    required this.taskDate,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunc,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.orange[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.orange[800],
              ),
              // Nazwa zadania i data
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskName,
                    style: TextStyle(
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  Text(
                    'Termin: ${taskDate.day}.${taskDate.month}.${taskDate.year}',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
