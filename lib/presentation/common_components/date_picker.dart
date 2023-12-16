import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';
import 'package:table_calendar/table_calendar.dart';

showAppDatePicker(
  BuildContext context, {
  required final DateTime selectedDate,
  final DateTime? firstDay,
  final DateTime? lastDay,
  required final Function(DateTime, DateTime) onDateSelected,
}) {
  showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.close,
                  size: 30.w,
                ),
              ),
            ).paddingOnly(top: 20.w, right: 20.w),
            TableCalendar(
              firstDay: firstDay ?? DateTime.utc(2022, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              currentDay: DateTime.utc(2200, 1, 1),
              focusedDay: selectedDate.isAfter(firstDay ?? DateTime.utc(2022, 1, 1))
                  ? selectedDate
                  : firstDay ?? DateTime.utc(2022, 1, 1),
              headerStyle: const HeaderStyle(titleCentered: true),
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(color: AppColors().lightBlue.withOpacity(0.5), shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(color: AppColors().primaryColor, shape: BoxShape.circle),
              ),
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
              },
              selectedDayPredicate: (day) {
                return isSameDay(selectedDate, day);
              },
              onDaySelected: (selected, focused){
                onDateSelected(selected, focused);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
