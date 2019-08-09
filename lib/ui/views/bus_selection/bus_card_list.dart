import 'package:bus_booking/core/models/bus.dart';
import 'package:flutter/material.dart';

import 'bus_card_item.dart';

class BusCardList extends StatelessWidget {
  const BusCardList({
    Key key,
    @required this.items,
    this.animatedListKey,
    this.controller,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0),
    this.onTap,
  }) : super(key: key);

  final GlobalKey<AnimatedListState> animatedListKey;
  final ScrollController controller;

  final List<BusSchedule> items;
  final EdgeInsets padding;
  final Function(BusSchedule) onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      child: items.length == 0 
        ? _buildEmptyState(context)
        : _buildList()
    );
  }

  Widget _buildList() {
    return ListView.separated(
      padding: padding,
      itemCount: items.length,
      itemBuilder: (_, int i) => BusCardItem(
        key: ValueKey<String>(items[i].id),
        item: items[i],
        onTap: () => onTap != null ? onTap(items[i]) : null,
      ),
      separatorBuilder: (_, int i) => Divider(),
    );

    // return AnimatedList(
    //   key: animatedListKey,
    //   controller: controller,
    //   padding: padding,
    //   initialItemCount: items.length,
    //   itemBuilder: (BuildContext context, int i, Animation animation) {
    //     return FadeTransition(
    //       opacity: animation,
    //       child: BusCardItem(
    //         key: ValueKey<String>(items[i].id),
    //         item: items[i],
    //         onTap: () => onTap != null ? onTap(items[i]) : null,
    //       ),
    //     );
    //   }
    // );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
              child: Image.asset('assets/images/waiting.png'),
            ),
            SizedBox(height: 12.0),
            Text('No buses found', style: Theme.of(context).textTheme.title.copyWith(
              fontWeight: FontWeight.normal
            )),
          ],
        ),
      )
    );
  }
}