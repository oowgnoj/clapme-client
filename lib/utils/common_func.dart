String convertDayBooltoStr(Map<String, dynamic> daysBool) {
  // true 인 요일만 daysStr에 추가
  List<String> daysStr = [];
  daysBool.forEach((day, isTrue) => isTrue ? daysStr.add(day) : null);
  if (daysStr.length == 7 || daysStr.length == 5 || daysStr.length == 2) {
    if (daysStr.length == 7) {
      return 'everyday';
    }
    if (daysStr.length == 2) {
      if (daysStr.contains('sat') && daysStr.contains('sun')) {
        return 'weekends';
      }
    }
    if (daysStr.length == 5) {
      if (!daysStr.contains('sat') && !daysStr.contains('sun')) {
        return 'weekdays';
      }
    }
  }
  return daysStr.join(',').toString();
}
