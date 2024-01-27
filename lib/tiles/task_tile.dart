// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project/pages/home_page.dart';

class TaskTile extends StatefulWidget {
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
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Slidable(
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  onPressed: widget.deleteFunc,
                  backgroundColor: Colors.red.shade300,
                  icon: Icons.delete,
                )
              ],
            ),
            child: buildTask(context),
          ),
        ),
      );

  Widget buildTask(BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        decoration: BoxDecoration(
          color: MyColors.aBColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //checkbox
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Transform.scale(
                scale: 1.6,
                child: Checkbox(
                  side: BorderSide(width: 1, color: Colors.white),
                  value: widget.taskCompleted,
                  onChanged: widget.onChanged,
                  checkColor: Colors.white,
                  activeColor: Colors.orange,
                ),
              ),
            ),

            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: Colors.orange,
                          width: 2,
                          style: BorderStyle.solid))),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: widget.taskName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Oxygen',
                            fontWeight: FontWeight.w700,
                            decoration: widget.taskCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      //opis zadania
                      if (widget.taskDescription.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: RichText(
                            text: TextSpan(
                              text: widget.taskDescription,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Oxygen',
                                fontWeight: FontWeight.w500,
                                decoration: widget.taskCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
