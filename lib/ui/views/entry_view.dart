import 'package:bus_booking/core/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:bus_booking/core/config/constants.dart';
import 'package:bus_booking/ui/widgets/custom_ui.dart';
import 'package:bus_booking/ui/shared/theme.dart';

class EntryView extends StatefulWidget {
  @override
  _EntryViewState createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> with TickerProviderStateMixin {

  KeyboardVisibilityNotification _keyboardVisibilityNotification = KeyboardVisibilityNotification();
  bool _isKeyboardVisible = false;

  ScrollController _scrollController = ScrollController();

  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _keyboardVisibilityNotification.addNewListener(
      onChange: _onKeyboardChanged
    );
  }

  void _onKeyboardChanged(bool visible) {
    setState(() => _isKeyboardVisible = visible);

    if (_isKeyboardVisible) {
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn
        );
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _keyboardVisibilityNotification.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: SizedBox(
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 400),
                    opacity: _isKeyboardVisible ? 0 : 1,
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Image.asset('assets/images/travelers.png'),
                      ),
                    ),
                  ),
                ),
                _buildFormLayout()
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _buildFormLayout() {
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(48.0), 
          topRight: Radius.circular(48.0)
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.35),
            spreadRadius: 6, 
            blurRadius: 12.0,
          ),
        ],
      ),
      child: _buildFormContent()
    );
  }

  Widget _buildFormContent() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          Text('Welcome to', style: Theme.of(context).textTheme.headline.copyWith(
            color: Colors.white
          )),
          Text(APP_NAME, style: Theme.of(context).textTheme.display1.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold
          )),
          SizedBox(height: 24.0),
          _buildForm(),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                child: Text('Create an Account'),
                textColor: Colors.white,
                onPressed: () => Navigator.of(context).pushNamed('/create-account'),
              ),
              FloatingActionButton(
                heroTag: 'submit',
                onPressed: () {},
                child: Icon(EvaIcons.arrowForward),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      child: Column(
        children: <Widget>[
          CustomTextField(
            focusNode: _emailFocus,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            labelText: 'Email Address',
            leftmostIcon: Icon(EvaIcons.emailOutline),
            onFieldSubmitted: (_) => Utils.fieldFocusChange(context, _emailFocus, _passwordFocus),
          ),
          SizedBox(height: 16.0),
          CustomTextField(
            focusNode: _passwordFocus,
            obscureText: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            labelText: 'Password',
            leftmostIcon: Icon(EvaIcons.lockOutline),
          ),
        ],
      ),
    );
  }
}