import 'package:intl/intl.dart';
class DateUtil {
  static const DATE_FORMAT = 'yyyy/MM/dd';
  String formattedDate(DateTime dateTime) {
    print('dateTime ($dateTime)');
    
    return DateFormat(DATE_FORMAT).format(dateTime);

    //DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  }
}