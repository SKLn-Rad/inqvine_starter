import 'package:jiffy/jiffy.dart';

const String _extendedJiffyPattern = 'hh:mma - do MMMM yyyy';

extension IntTimeExtensions on int {
  String get formatAsEpochSecondsExtended {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this * 1000);
    final Jiffy jiffy = Jiffy(dateTime);
    return jiffy.format(_extendedJiffyPattern);
  }
}
