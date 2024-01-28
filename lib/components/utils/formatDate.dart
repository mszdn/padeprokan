import 'package:intl/intl.dart';

String formatDate({required String date}) {
  DateTime tanggalTarget = DateTime.parse(date);
  DateFormat formatter = DateFormat.yMEd().add_jms();
  String formatted = formatter.format(tanggalTarget);

  return formatted;
}
