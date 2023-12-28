// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project/buttons/desc_btn.dart';
import 'package:project/pages/home_page.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final String taskDescription;
  final DateTime taskDate;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunc;

  TaskTile({
    super.key,
    required this.taskName,
    required this.taskDescription,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunc,
    required this.taskDate,
  });

  //główny kod tasktile
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
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(253, 247, 239, 1),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //checkbox
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: MyColors.aBColor,
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //nazwa zadania
                  Text(
                    //ograniczenie długości znaków do 18, oraz dodanie przejscia do kolejnej linij
                    taskName.length > 18
                        ? '${taskName.substring(0, 18)}\n${taskName.substring(18)}'
                        : taskName,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 18,
                        fontFamily: 'Oxygen',
                        fontWeight: FontWeight.w500),
                  ),

                  //termin zadania
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Termin: ${taskDate.day}.${taskDate.month}.${taskDate.year}',
                      style: TextStyle(
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  //opis zadania
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      taskDescription.length > 25
                          ? '${taskDescription.substring(0, 20)}\n${taskDescription.substring(18)}'
                          : taskDescription,
                      maxLines: 5,
                      style: TextStyle(
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 15,
                        color: const Color.fromARGB(255, 78, 78, 78),
                      ),
                    ),
                  )
                ],
              ),

              DescBTN(onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
