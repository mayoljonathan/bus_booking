import 'package:bus_booking/ui/shared/theme.dart';
import 'package:flutter/material.dart';

class AmenityItem extends StatelessWidget {
  const AmenityItem({
    @required this.label,
    @required this.isSelected,
    @required this.onTap
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? kPrimaryColor : kGreyColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12.0)
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
              child: Text(label, style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold
              ))
            ),
          ),
        ),
      ),
    );
  }
}