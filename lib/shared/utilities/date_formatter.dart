import 'package:intl/intl.dart';
import 'package:web_extension/shared/utilities/log_util.dart';

final class DateFormatter {
  const DateFormatter._();

  static const String sqlDatePattern = "yyyy-MM-dd HH:mm:ss Z";
  static const String iso8601Pattern = 'yyyy-MM-ddTHH:mm:ssZ';

  static String? toSql(DateTime date) {
    try {
      final formatter = DateFormat(sqlDatePattern, 'en_US');
      return formatter.format(date);
    } catch (e, stack) {
      LogUtil.e(e.toString(), stackTrace: stack);
      return null;
    }
  }

  static DateTime? fromSql(String value) {
    try {
      final formatter = DateFormat(sqlDatePattern, 'en_US');
      return formatter.parse(value);
    } catch (e, stack) {
      LogUtil.e(e.toString(), stackTrace: stack);
      return null;
    }
  }

  static String dateToString(DateTime date, {String pattern = iso8601Pattern}) {
    try {
      final formatter = DateFormat(pattern);
      return formatter.format(date);
    } catch (error, stackTrace) {
      LogUtil.e(
        'Date to String Formating Error',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
