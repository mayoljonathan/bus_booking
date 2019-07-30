import 'package:bus_booking/core/viewmodels/home_view_model.dart';
import 'package:bus_booking/core/viewmodels/user_model.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

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
      child: Padding(
        padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: kPrimaryColor,
              padding: const EdgeInsets.fromLTRB(24.0, 48.0, 24.0, 12.0),
              child: _buildUpperSection()
            ),
            _buildLowerSection(),
            SizedBox(height: 24.0)
          ],
        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: TripDate()
        ),
        SizedBox(height: 24.0),
        SeatChooser()
      ],
    );
  }

  Widget _buildOriginAndDestination() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildFieldItem(
          label: 'From',
          isOrigin: true
        ),
        _buildFieldItem(
          label: 'To',
          isOrigin: false
        ),
      ],
    );
  }

  Widget _buildFieldItem({@required String label, @required bool isOrigin}) {
    TextTheme textTheme = Theme.of(context).textTheme;

    final bookingDto = Provider.of<HomeViewModel>(context).bookingDto;
    String placeName = isOrigin ? bookingDto.origin?.name : bookingDto.destination?.name;
    
    String placeholder = 'Select ';
    if (placeName == null) placeholder += isOrigin ? 'origin' : 'destination';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: textTheme.subtitle.copyWith(
          color: Colors.white70,
          letterSpacing: 0.5,
        )),
        Padding(
          padding: const EdgeInsets.only(top: 6.0, bottom: 18.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              onTap: () => print('TODO'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(placeName ?? placeholder, style: textTheme.headline.copyWith(
                            color: (placeName != null) ? Colors.white : Colors.white54,
                            fontWeight: (placeName != null) ? FontWeight.bold : FontWeight.w100,
                          )),
                        ),
                        SizedBox(width: 6.0),
                        Icon(EvaIcons.chevronRight, color: Colors.white70, size: 30)
                      ],
                    ),
                  ),
                  Divider(color: Colors.white, height: 1.0)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

}