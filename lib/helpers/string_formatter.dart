import 'package:html/parser.dart';
import 'package:intl/intl.dart';

String getMonthFromString(String date) {
  date = date.toLowerCase();
  var month = '';
  if (date.contains('jan')) {
    month = 'Januari';
  } else if (date.contains('feb')) {
    month = 'Februari';
  } else if (date.contains('mar')) {
    month = 'Maret';
  } else if (date.contains('apr')) {
    month = 'April';
  } else if (date.contains('may')) {
    month = 'Mei';
  } else if (date.contains('jun') || date.contains('june')) {
    month = 'Juni';
  } else if (date.contains('jul') || date.contains('july')) {
    month = 'Juli';
  } else if (date.contains('aug')) {
    month = 'Agustus';
  } else if (date.contains('sep') || date.contains('sept')) {
    month = 'September';
  } else if (date.contains('oct')) {
    month = 'Oktober';
  } else if (date.contains('nov')) {
    month = 'November';
  } else if (date.contains('dec')) {
    month = 'Desember';
  } else {
    month = date;
  }
  return month;
}

String getAbbrMonthFromNum(String date) {
  var monthAndDate = date.substring(date.length - 5);
  var month = monthAndDate.substring(0, monthAndDate.length - 3);
  switch (month) {
    case '1':
      return 'Jan';
    case '2':
      return 'Feb';
    case '3':
      return 'Mar';
    case '4':
      return 'Apr';
    case '5':
      return 'Mei';
    case '6':
      return 'Jun';
    case '7':
      return 'Jul';
    case '8':
      return 'Agu';
    case '9':
      return 'Sep';
    case '10':
      return 'Okt';
    case '11':
      return 'Nov';
    case '12':
      return 'Des';
    default:
      return date;
  }
}

String parseHtmlString(String htmlString) {
  var parsedString = parse(htmlString).documentElement!.text;
  return parsedString;
}

String getDate(DateTime date) {
  if (date.day == DateTime.now().day) {
    return 'Hari Ini';
  }
  if (date.day == DateTime.now().subtract(const Duration(days: 1)).day) {
    return 'Kemarin';
  }
  return DateFormat('dd MMM yyyy').format(date);
}
