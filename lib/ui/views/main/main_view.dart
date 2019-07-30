import 'package:bus_booking/core/viewmodels/home_view_model.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:bus_booking/ui/views/home/home_view.dart';
import 'package:bus_booking/ui/views/profile/profile_view.dart';
import 'package:bus_booking/ui/views/ticket/ticket_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  final HomeViewModel _homeViewModel = HomeViewModel();

  final PageStorageBucket _bucket = PageStorageBucket();
  final List<Widget> _pages = [
    TicketView(key: PageStorageKey('Tickets')),
    HomeView(key: PageStorageKey('Search')),
    ProfileView(key: PageStorageKey('Profile'))
  ];
  int _currentBottomIndex = 1;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>.value(value: _homeViewModel)
      ],
      child: Scaffold(
        body: PageStorage(
          child: _pages[_currentBottomIndex],
          bucket: _bucket,
        ),
        extendBody: true,
        bottomNavigationBar: _buildBottomNavBar(),
        floatingActionButton: _currentBottomIndex == 1 ? _buildFab() : null,
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2.0,
            blurRadius: 8.0
          ),
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0)
        ),
        child: CubertoBottomBar(
          inactiveIconColor: kGreyColor,
          initialSelection: _currentBottomIndex,
          tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND,
          textCurve: Curves.easeInOutExpo,
          tabs: [
            TabData(
              iconData: EvaIcons.fileTextOutline,
              title: "Tickets",
              tabColor: kAccentColor),
            TabData(
              iconData: EvaIcons.homeOutline,
              title: "Home",
              tabColor: kPrimaryColor),
            TabData(
              iconData: EvaIcons.personOutline,
              title: "You",
              tabColor: kAccentColor),
          ],
          onTabChangedListener: (int position, _, __) {
            setState(() => _currentBottomIndex = position);
          },
        )
      ),
    );
  }

  Widget _buildFab() {
    return FloatingActionButton.extended(
      heroTag: 'submit',
      label: Text('Find your Bus'),
      onPressed: _homeViewModel.onFindBusTap,
    );
  }
}