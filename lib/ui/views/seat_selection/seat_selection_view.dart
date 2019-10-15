import 'package:bus_booking/core/models/bus.dart';
import 'package:bus_booking/core/viewmodels/seat_selection_view_model.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:bus_booking/ui/views/base_view.dart';
import 'package:bus_booking/ui/widgets/custom_ui.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class SeatSelectionView extends StatelessWidget {
  const SeatSelectionView({
    Key key,
    @required this.busSchedule
  });

  final BusSchedule busSchedule;

  @override
  Widget build(BuildContext context) {
    return BaseView<SeatSelectionViewModel>(
      onModelReady: (model) => model.getSeatsData(),
      builder: (_,model,___) => Scaffold(
        appBar: RoundedAppBar(
          title: _buildTitle(context),
          bottom: _buildAppBarBottom(context, model)
        ),
        body: _buildBody(),
        bottomNavigationBar: _buildBottom()
      )
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Text('Select Seats', style: Theme.of(context).textTheme.title.copyWith(
        fontWeight: FontWeight.bold
      )),
    );
  }

  Widget _buildAppBarBottom(BuildContext context, SeatSelectionViewModel model) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return PreferredSize(
      preferredSize: Size.fromHeight(44),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: InkWell(
          onTap: () => model.onBusInfoTap(context, busSchedule),
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(busSchedule.bus.company.name, 
                      style: textTheme.subhead.copyWith(
                        fontWeight: FontWeight.w500
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 3.0),
                    Text(busSchedule.seatsAvailableToString(), 
                      style: textTheme.caption,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Positioned.fill(
                  right: 9.0,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(EvaIcons.expandOutline, color: kAccentColor)
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Placeholder()
    );
  }

  Widget _buildBottom() {
    return Material(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0)
      ),
      elevation: 12.0,
      color: Colors.white,
      child: SizedBox(
        height: kToolbarHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text('todo'),
        )
      ),
    );
  }

}



