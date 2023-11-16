import 'package:intl/intl.dart';

class TimeServices{
  // 메서드 - 두 DateTime 변수의 차이를 시간과 분으로 나타내기
  static timePlogging(DateTime start, DateTime end) {
    final Duration difference = end.difference(start);
    final int hours = difference.inHours;
    final int minutes = difference.inMinutes.remainder(60);

    final formattedTimeDifference = DateFormat('HH:mm').format(
      DateTime(0, 1, 1, hours, minutes),
    );

    return formattedTimeDifference;
  }
}