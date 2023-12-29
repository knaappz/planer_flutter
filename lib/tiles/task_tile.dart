// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project/pages/home_page.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final String taskDescription;
  final DateTime taskDate;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunc;

  TaskTile({
    Key? key, // Poprawiłem miejsce, w którym znajduje się key
    required this.taskName,
    required this.taskDescription,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunc,
    required this.taskDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunc,
              backgroundColor: Colors.red.shade300,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(20),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          decoration: BoxDecoration(
            color: MyColors.tileColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              //checkbox
              Transform.scale(
                scale: 1.2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    activeColor: MyColors.aBColor,
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //nazwa zadania
                  SizedBox(
                    width: 240,
                    child: RichText(
                      text: TextSpan(
                        text: taskName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Oxygen',
                          fontWeight: FontWeight.w700,
                          decoration: taskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  //opis zadania
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: 240,
                      child: RichText(
                        text: TextSpan(
                          text: 'Opis: $taskDescription',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.w500,
                            decoration: taskCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Do: ${taskDate.day}.${taskDate.month}.${taskDate.year}',
                      style: TextStyle(
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 15,
                        fontFamily: 'Oxygen',
                        color: Colors.deepOrange,
                      ),
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
