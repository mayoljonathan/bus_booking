import 'package:bus_booking/core/viewmodels/home_view_model.dart';
import 'package:bus_booking/core/viewmodels/user_model.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'field_item.dart';
import 'location_field.dart';
import 'trip_date.dart';

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
          child: _buildFieldsList(),
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

  Widget _buildFieldsList() {
    final bookingDto = Provider.of<HomeViewModel>(context).bookingDto;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            FieldItem(
              label: 'From',
              child: LocationField(
                placeName: bookingDto.origin?.name,
                placeholder: 'Select origin',
                padding: const EdgeInsets.fromLTRB(0, 12.0, 36.0, 12.0),
                onTap: () => Provider.of<HomeViewModel>(context).onFieldItemTap(context, true),
              )
            ),
            if (Provider.of<HomeViewModel>(context).shouldShowSwapLocationButton()) 
            Positioned(
              bottom: 0,
              right: 12,
              child: _buildSwapButton()
            )
          ],
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

  Widget _buildSwapButton() {
    return Material(
      borderRadius: BorderRadius.circular(24.0),
      elevation: 2.0,
      color: kAccentColor,
      child: Tooltip(
        message: 'Swap',
        margin: const EdgeInsets.only(top: 6.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(24.0),
          onTap: Provider.of<HomeViewModel>(context).swapLocation,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(EvaIcons.flipOutline, color: Colors.white)
          )
        ),
      ),
    );
  }

}