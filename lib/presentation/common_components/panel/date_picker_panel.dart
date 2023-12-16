import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_street_merchant/data/constants/app_colors.dart';
import 'package:my_street_merchant/utils/extensions/padding_extensions.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:table_calendar/table_calendar.dart';

class DatePickerPanel extends StatelessWidget {
  final PanelController panelController;
  final DateTime selectedDate;
  final DateTime? firstDay;
  final DateTime? lastDay;
  final Function(DateTime, DateTime) onDateSelected;

  const DatePickerPanel({
    Key? key,
    required this.panelController,
    required this.selectedDate,
    this.firstDay,
    this.lastDay,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: panelController,
      maxHeight: 0.6.sh,
      minHeight: 0.3,
      boxShadow: [
        BoxShadow(
          offset: const Offset(1, 1),
          blurRadius: 5,
          color: Colors.black.withOpacity(0.2),
        ),
      ],
      backdropColor: Colors.black,
      backdropOpacity: 0.3,
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      panelBuilder: (ScrollController sc) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                panelController.close();
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
              onDaySelected: onDateSelected,
            ),
          ],
        );
      },
    );
  }
}
