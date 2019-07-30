import 'package:bus_booking/core/viewmodels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'seat_item.dart';

class SeatChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text('Number of Seats', style: textTheme.subtitle.copyWith(
            letterSpacing: 0.5,
          )),
        ),
        SizedBox(height: 12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _buildSeatItems(context).toList()
          ),
        )
        // SizedBox(
        //   height: 48.0,
        //   child: ListView.separated(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: model.maxSeats,
        //     separatorBuilder: (ctx, int index) => SizedBox(width: 6.0),
        //     itemBuilder: (ctx, int index) {
        //       EdgeInsetsGeometry padding = EdgeInsets.all(0);
        //       if (index == 0) {
        //         padding = EdgeInsets.only(left: 24.0);
        //       } else if (model.maxSeats == index + 1) {
        //         padding = EdgeInsets.only(right: 24.0);
        //       }

        //       return Padding(
        //         padding: padding,
        //         child: SeatItem(
        //           number: index + 1,
        //           isSelected: model.bookingDto.numberOfSeats == index + 1,
        //           onTap: () => model.setNumberOfSeat(index + 1)
        //         )
        //       );
        //     }
        //   ),
        // )
      ],
    );
  }

  List<Widget> _buildSeatItems(context) {
    final model = Provider.of<HomeViewModel>(context);

    List<Widget> widgets = [];

    for (int i = 0; i < model.maxSeats; i++) {
      EdgeInsetsGeometry padding = EdgeInsets.all(0);
      if (i == 0) {
        padding = EdgeInsets.only(left: 24.0);
      } else if (model.maxSeats == i + 1) {
        padding = EdgeInsets.only(right: 24.0);
      }

      widgets.add(Padding(
        padding: padding,
        child: SeatItem(
          number: i + 1,
          isSelected: model.bookingDto.numberOfSeats == i + 1,
          onTap: () => model.setNumberOfSeat(i + 1)
        )
      ));
    }

    return widgets;
  }
}