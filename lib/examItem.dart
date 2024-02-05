import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'exam.dart';
import 'colors.dart';

class ExamItem extends StatelessWidget {
  final Exam exam;

  const ExamItem({Key? key, required this.exam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final examDate = DateTime.parse(exam.date!);
    final formattedDate = DateFormat('dd-MM-yyyy').format(examDate);

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        title: Text(
          exam.examText!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Black,
          ),
        ),
        subtitle: Text(
          formattedDate,
          style: TextStyle(
            fontSize: 12,
            color: Grey,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
        ),
      ),
    );
  }
}
