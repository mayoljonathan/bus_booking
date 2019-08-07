import 'package:bus_booking/core/models/amenity.dart';
import 'package:bus_booking/core/viewmodels/bus_selection_view_model.dart';
import 'package:bus_booking/core/viewmodels/home_view_model.dart';
import 'package:bus_booking/locator.dart';
import 'package:bus_booking/ui/widgets/custom_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'amenity_list.dart';

class BusSelectionView extends StatefulWidget {
  const BusSelectionView({
    @required this.homeViewModel,
  });

  final HomeViewModel homeViewModel;

  @override
  _BusSelectionViewState createState() => _BusSelectionViewState();
}

class _BusSelectionViewState extends State<BusSelectionView> {
  
  final List<Amenity> _amenities = [
    Amenity(id: 'ac', name: 'A/C'),
    Amenity(id: 'wifi', name: 'Free Wi-Fi'),
    Amenity(id: 'rr', name: 'Restroom'),
  ];

  final BusSelectionViewModel _busSelectionViewModel = locator<BusSelectionViewModel>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (ctx) => _busSelectionViewModel,
      child: Scaffold(
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
          child: AmenityList(items: _amenities)
        )
      )
    );
  }

  Widget _buildBody() {
    // TODO
  }
}