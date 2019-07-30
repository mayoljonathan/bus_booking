import 'package:bus_booking/ui/shared/theme.dart';
import 'package:flutter/material.dart';

class SeatItem extends StatelessWidget {
  const SeatItem({
    @required this.number,
    @required this.isSelected,
    @required this.onTap
  });

  final int number;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    String noun = 'seat';
    noun += number > 1 ? 's' : '';

    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? kPrimaryColor.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12.0)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: Text('$number $noun', style: TextStyle(
            color: isSelected ? kPrimaryColor : kGreyColor,
            fontWeight: FontWeight.bold
          ))
        ),
      ),
    );
  }
}