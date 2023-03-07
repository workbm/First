import 'package:flutter/animation.dart';

class WorkDay {
  int id, agencyID, openAllDay, closedAllDay;
  String name, start, end;
  WorkDay({
    required this.id,
    required this.agencyID,
    required this.name,
    required this.start,
    required this.end,
    required this.openAllDay,
    required this.closedAllDay,
  });
}
