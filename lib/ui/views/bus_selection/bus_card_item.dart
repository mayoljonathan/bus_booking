import 'package:bus_booking/core/models/amenity.dart';
import 'package:bus_booking/core/models/bus.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

// class BusCardItem extends StatelessWidget {

//   const BusCardItem({
//     Key key,
//     @required this.item,
//     this.onTap
//   }) : super(key: key);

//   final BusSchedule item;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12.0),
//       child: Container(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       _buildTime(context),
//                       _buildBusCompany(context)
//                     ],
//                   ),
//                 ),
//                 _buildFare(context)
//               ],
//             ),
//             SizedBox(height: 18.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Expanded(child: _buildAmenitiesList(context)),
//                 SizedBox(width: 12.0),
//                 _buildSeatsAvailable(context)
//               ],
//             )
//           ],
//         )
//       ),
//     );
//   }

//   Widget _buildTime(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;

//     return Row(
//       children: <Widget>[
//         Text(item.departureTime, style: textTheme.subtitle.copyWith(
//           color: kPrimaryColor
//         )),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//           child: Icon(EvaIcons.arrowForwardOutline, size: 20, color: kPrimaryColor)
//         ),
//         Text(item.arrivalTime, style: textTheme.subtitle.copyWith(
//           color: kPrimaryColor
//         )),
//       ],
//     );
//   }

//   Widget _buildBusCompany(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;

//     return Text(item.bus.busCompany.name, style: textTheme.title.copyWith(
//       fontWeight: FontWeight.bold
//     ));
//   }

//   Widget _buildFare(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;

//     return Text(item.amountToString(decimals: 0), style: textTheme.headline.copyWith(
//       fontWeight: FontWeight.w500,
//     ));
//   }

//   Widget _buildAmenitiesList(BuildContext context) {
//     // TODO
//     if (item.amenities == null || item.amenities.length < 0) return Container();

//     return Wrap(
//       children: <Widget>[
//         for (Amenity amenity in item.amenities) 
//         Text(amenity.name)
//       ],
//     );
//   }

//   Widget _buildSeatsAvailable(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;

//     String noun = 'seat';
//     if (item.availableSeats > 1) noun += 's';
//     String message = '${item.availableSeats} $noun available';

//     return Text(message, style: textTheme.body1.copyWith(
//       color: textTheme.caption.color
//     ));

//   }
// }

class BusCardItem extends StatefulWidget {

  const BusCardItem({
    Key key,
    @required this.item,
    this.onTap
  }) : super(key: key);

  final BusSchedule item;
  final VoidCallback onTap;

  @override
  _BusCardItemState createState() => _BusCardItemState();
}

class _BusCardItemState extends State<BusCardItem> with TickerProviderStateMixin {

  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500), 
      vsync: this,
      lowerBound: 0.1,
    );            

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve:  Curves.fastOutSlowIn,
      reverseCurve: Curves.fastOutSlowIn
    ));

    _animationController.addListener(() => setState(() {}));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _animation.value,
      child: AnimatedOpacity(
        opacity: _animation.value,
        duration: Duration(milliseconds: 200),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildTime(context),
                          _buildBusCompany(context)
                        ],
                      ),
                    ),
                    _buildFare(context)
                  ],
                ),
                SizedBox(height: 18.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(child: _buildAmenitiesList(context)),
                    SizedBox(width: 12.0),
                    _buildSeatsAvailable(context)
                  ],
                )
              ],
            )
          ),
        ),
      )
    );
  }

  Widget _buildTime(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: <Widget>[
        Text(widget.item.departureTime, style: textTheme.subtitle.copyWith(
          color: kPrimaryColor
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Icon(EvaIcons.arrowForwardOutline, size: 20, color: kPrimaryColor)
        ),
        Text(widget.item.arrivalTime, style: textTheme.subtitle.copyWith(
          color: kPrimaryColor
        )),
      ],
    );
  }

  Widget _buildBusCompany(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Text(widget.item.bus.company.name, style: textTheme.title.copyWith(
      fontWeight: FontWeight.bold
    ));
  }

  Widget _buildFare(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Text(widget.item.amountToString(decimals: 0), style: textTheme.headline.copyWith(
      fontWeight: FontWeight.w500,
    ));
  }

  Widget _buildAmenitiesList(BuildContext context) {
    // TODO
    if (widget.item.amenities == null || widget.item.amenities.length < 0) return Container();

    return Wrap(
      children: <Widget>[
        for (Amenity amenity in widget.item.amenities) 
        Text(amenity.name)
      ],
    );
  }

  Widget _buildSeatsAvailable(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Text(widget.item.seatsAvailableToString(), style: textTheme.body1.copyWith(
      color: textTheme.caption.color
    ));

  }
}