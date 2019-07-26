import 'package:bus_booking/ui/shared/theme.dart';
import 'package:bus_booking/ui/views/base_view.dart';
import 'package:bus_booking/ui/views/create_account/create_account_model.dart';
import 'package:bus_booking/ui/widgets/custom_ui.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'email_address_section.dart';
import 'mobile_number_section.dart';
import 'name_section.dart';
import 'password_section.dart';
import 'verify_mobile_number_section.dart';

class CreateAccountView extends StatefulWidget {

  @override
  _CreateAccountViewState createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  PageController _pageController = PageController();
  ScrollController _scrollController = ScrollController();

  KeyboardVisibilityNotification _keyboardVisibilityNotification = KeyboardVisibilityNotification();

  List<Widget> _viewWidgets;
  int _currentIndex = 0;

  double _appBarHeight = 140.0;
  CreateAccountModel _model;

  @override
  void initState() {
    super.initState();

    _viewWidgets = <Widget>[
      MobileNumberSection(
        onNextTap: () => _animateToPage(1)
      ),
      VerifyMobileNumberSection(
        onNextTap: () => _animateToPage(2),
      ),
      EmailAddressSection(
        onBackTap: () => _animateToPage(0),
        onNextTap: () => _animateToPage(3)
      ),
      PasswordSection(
        onBackTap: () => _animateToPage(2),
        onNextTap: () => _animateToPage(4),
      ),
      NameSection(
        onBackTap: () => _animateToPage(3),
        onNextTap: () => Navigator.of(context).pushReplacementNamed('/create-account-success', 
          arguments: _model
        )
      ),
    ];

    _keyboardVisibilityNotification.addNewListener(onChange: _onKeyboardChanged);
  }

  void _animateToPage(int index) {
    _pageController.animateToPage(index,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOutExpo
    );
  }

  @override
  void dispose() {
    super.dispose();
    _keyboardVisibilityNotification.dispose();
    _scrollController.dispose();
    _pageController.dispose();
  }

  void _onKeyboardChanged(bool visible) {
    if (visible) {
      Future.delayed(Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(_appBarHeight / 3.8,
            duration: Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CreateAccountModel>(
      onModelReady: (model) => _model = model,
      builder: (context, model, child) {
        return Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: Scaffold(
            body: CustomSliverBody(
              controller: _scrollController,
              title: Text('Create an Account', style: Theme.of(context).textTheme.title),
              body: SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.8,
                      child: PageView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        pageSnapping: true,
                        itemCount: _viewWidgets.length,
                        onPageChanged: (int index) => setState(() => _currentIndex = index),
                        controller: _pageController,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: _viewWidgets[index]
                        )
                      ),
                    ),
                  ],
                )
              ),
              extraLayer: _buildBottom()
            ),
          ),
        );
      },
    );
  }

  Widget _buildCircleIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? kPrimaryColor : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }

  Widget _buildBottom() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: kToolbarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            for (int i = 0; i < _viewWidgets.length; i++)
              if (i == _currentIndex) ...[_buildCircleIndicator(true)] 
              else _buildCircleIndicator(false),
          ],
        ),
      ),
    );
  }

}





