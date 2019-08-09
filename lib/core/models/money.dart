import 'package:intl/intl.dart';

class Money {
  final double amount;

  Money({this.amount});

  String amountToString({int decimals: 2}) {
    if (amount != null) {
      final formatter = NumberFormat.simpleCurrency(name: '', decimalDigits: decimals);
      return '₱ ${formatter.format(amount)}';
    }
    return '';
  }
}