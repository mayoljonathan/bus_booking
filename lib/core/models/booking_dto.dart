import 'place.dart';
import 'package:intl/intl.dart';

class BookingDto {
  Place origin;
  Place destination;
  DateTime date;
  int numberOfSeats;

  BookingDto({
    this.origin,
    this.destination,
    this.date,
    this.numberOfSeats
  });

  String getDateReadable() {
    final DateFormat formatter = DateFormat("EEEE',' MMMM d, yyyy");
    return formatter.format(date);
  }
}