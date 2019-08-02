import 'package:bus_booking/core/viewmodels/home_view_model.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          accentTextTheme: TextTheme(
            body1: Theme.of(context).textTheme.body1.copyWith(color: Colors.white)
          )
        ),
        child: Builder(
          builder: (context) => Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _onDateTap(context),
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: kAccentColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12.0)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(model.bookingDto.getDateReadable(), 
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    SizedBox(width: 12.0),
                    Icon(EvaIcons.chevronRightOutline, color: Colors.white)
                  ],
                ),
              ),
            )
          )
        )
      ),
    );
  }

  void _onDateTap(BuildContext context) async {
    final model = Provider.of<HomeViewModel>(context);
    DateTime today = DateTime.now();

    DateTime selectedDate = await showDatePicker(
      context: context,
      initialDate: model.bookingDto.date,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: today.add(Duration(days: 90)),
    );
    if (selectedDate != null) model.setTripDate(selectedDate);
  }
}