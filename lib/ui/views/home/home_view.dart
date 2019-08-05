import 'package:bus_booking/core/viewmodels/home_view_model.dart';
import 'package:bus_booking/core/viewmodels/user_model.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'field_item.dart';
import 'location_field.dart';
import 'trip_date.dart';
import 'seat_chooser.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  UserModel _userModel;

  @override
  void initState() {
    super.initState();
    _userModel = Provider.of<UserModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: _buildBody()
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: kPrimaryColor,
            padding: const EdgeInsets.fromLTRB(24.0, 48.0, 24.0, 0.0),
            child: _buildUpperSection()
          ),
          _buildLowerSection(),
        ],
      ),
    );
  }

  Widget _buildUpperSection() {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Hello, ${_userModel.currentUser.displayName}!', style: textTheme.headline.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500
        )),
        SizedBox(height: 3.0),
        Text('What is your next trip?', style: textTheme.subhead.copyWith(
          color: Colors.white70,
          fontWeight: FontWeight.w500
        )),
        Padding(
          padding: const EdgeInsets.only(top: 36.0),
          child: _buildOriginAndDestination(),
        )
      ],
    );
  }

  Widget _buildLowerSection() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 48.0, bottom: 48.0 + kBottomNavigationBarHeight),
        child: _buildFab()
      )
    );
  }

  Widget _buildOriginAndDestination() {
    final bookingDto = Provider.of<HomeViewModel>(context).bookingDto;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FieldItem(
          label: 'From',
          child: LocationField(
            placeName: bookingDto.origin?.name,
            placeholder: 'Select origin',
            onTap: () => Provider.of<HomeViewModel>(context).onFieldItemTap(context, true),
          )
        ),
        FieldItem(
          label: 'To',
          child: LocationField(
            placeName: bookingDto.destination?.name,
            placeholder: 'Select destination',
            onTap: () => Provider.of<HomeViewModel>(context).onFieldItemTap(context, false),
          )
        ),
        FieldItem(
          label: 'Trip Date',
          child: TripDate()
        ),
      ],
    );
  }

  Widget _buildFab() {
    return FloatingActionButton.extended(
      heroTag: 'submit',
      // child: Icon(EvaIcons.arrowForwardOutline),
      label: Text('FIND YOUR BUS'),
      onPressed: () => Provider.of<HomeViewModel>(context).onFindBusTap(context),
    );
  }

}