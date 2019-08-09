import 'package:bus_booking/core/models/bus.dart';
import 'package:bus_booking/core/viewmodels/base_model.dart';
import 'package:bus_booking/core/viewmodels/bus_selection_view_model.dart';
import 'package:bus_booking/core/viewmodels/home_view_model.dart';
import 'package:bus_booking/ui/views/base_view.dart';
import 'package:bus_booking/ui/widgets/custom_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'amenity_list.dart';
import 'bus_card_list.dart';

class BusSelectionView extends StatefulWidget {
  const BusSelectionView({
    @required this.homeViewModel,
  });

  final HomeViewModel homeViewModel;

  @override
  _BusSelectionViewState createState() => _BusSelectionViewState();
}

class _BusSelectionViewState extends State<BusSelectionView> {
  
  @override
  Widget build(BuildContext context) {
    return BaseView<BusSelectionViewModel>(
      onModelReady: (model) => model.getBusSchedules(),
      builder: (_,__,___) => Scaffold(
        appBar: RoundedAppBar(
          title: _buildTitle(),
          bottom: _buildBottom()
        ),
        body: _buildBody(),
        // floatingActionButton: FloatingActionButton.extended(
        //   icon: Icon(EvaIcons.swap),
        //   label: Text('Filter'),
        //   onPressed: () {},
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
      )
    );
  }

  Widget _buildTitle() {
    String origin = widget.homeViewModel.bookingDto.origin.name;
    String destination = widget.homeViewModel.bookingDto.destination.name;

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Text('$origin to $destination', 
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.subhead.copyWith(
          fontWeight: FontWeight.bold
        )
      ),
    );
  }

  Widget _buildBottom() {
    return PreferredSize(
      preferredSize: Size.fromHeight(44),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        height: 44,
        child: Material(
          color: Colors.transparent,
          child: Consumer<BusSelectionViewModel>(
            builder: (_,model,__) {
              if (model.state != ViewState.BUSY) return AmenityList(
                items: model.getAvailableFilterAmenities()
              );
              return Container();
            }
          )
        )
      )
    );
  }

  Widget _buildBody() {
    return Consumer<BusSelectionViewModel>(
      builder: (_,model,__) {
        if (model.state == ViewState.BUSY) {
          return Center(child: CircularProgressIndicator());
        }

        return BusCardList(
          animatedListKey: model.animatedListKey,
          controller: model.scrollController,
          items: model.busSchedules,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          onTap: (BusSchedule busSchedule) => model.onBusScheduleTap(context, busSchedule)
        );
      },
    );
  }
}