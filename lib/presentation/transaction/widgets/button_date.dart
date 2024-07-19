import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/widgets/button/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDateButton extends StatelessWidget {
  const SelectDateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IBOutlinedButton(
      backgroundColor: AppColors.white,
      borderColors: Colors.transparent,
      title: DateFormat('dd MMM yy')
          .format(DateTime(DateTime.now().year, DateTime.september)),
      icon: Icon(Icons.calendar_month),
      onTap: () async {
        await showDatePicker(
          context: context,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime.now().year - 10),
          lastDate: DateTime(DateTime.now().year + 10),
        );
      },
    );
  }
}
