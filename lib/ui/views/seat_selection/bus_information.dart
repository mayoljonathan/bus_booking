import 'package:bus_booking/core/models/bus.dart';
import 'package:bus_booking/core/viewmodels/home_view_model.dart';
import 'package:bus_booking/locator.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusInformation extends StatefulWidget {
  const BusInformation({
    Key key,
    this.busSchedule,
  });

  final BusSchedule busSchedule;

  @override
  _BusInformationState createState() => _BusInformationState();
}

class _BusInformationState extends State<BusInformation> {

  double _opacity = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() => _opacity = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Material(
      color: Theme.of(context).canvasColor,
      child: SafeArea(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(milliseconds: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 12.0, 12.0, 12.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(widget.busSchedule.bus.company.name, style: textTheme.headline.copyWith(
                        fontWeight: FontWeight.bold
                      )),
                    ),
                    IconButton(
                      icon: Icon(EvaIcons.collapseOutline, color: kAccentColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildContent(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildMap(),
            _buildRouteContent(),
            _buildSection(
              title: 'Amenities',
              child: _buildAmenities()
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMap() {
    return Placeholder(
      fallbackHeight: 200,
    );
  }

  Widget _buildSection({ @required String title, @required Widget child }) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: textTheme.title),
          child
        ],
      ),
    );
  }

  Widget _buildRouteContent() {
    final model = locator<HomeViewModel>();
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Row(
        children: <Widget>[
          Expanded(child: _buildRouteItem(model.bookingDto.origin.name, widget.busSchedule.departureTime)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(EvaIcons.arrowForward)
          ),
          Expanded(child: _buildRouteItem(model.bookingDto.destination.name, widget.busSchedule.arrivalTime)),
        ],
      ),
    );
  }

  Widget _buildRouteItem(String name, String time) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: <Widget>[
        Text(name, 
          style: textTheme.subhead.copyWith(
            fontWeight: FontWeight.bold,
          color: kPrimaryColor
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 3.0),
        Text(time)
      ],
    );
  }

  Widget _buildAmenities() {
    // TODO
    return Container();
  }

}