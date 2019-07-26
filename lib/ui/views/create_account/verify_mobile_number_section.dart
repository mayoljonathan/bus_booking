import 'dart:async';
import 'package:bus_booking/core/helpers/ui_helper.dart';
import 'package:bus_booking/core/models/account_creation.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:pin_code_text_field/pin_code_text_field.dart';

import 'content_layout.dart';
import 'create_account_model.dart';

class VerifyMobileNumberSection extends StatefulWidget {
  const VerifyMobileNumberSection({
    this.onNextTap,
    this.onBackTap,
  });

  final VoidCallback onNextTap;
  final VoidCallback onBackTap;

  @override
  _VerifyMobileNumberSectionState createState() => _VerifyMobileNumberSectionState();
}

class _VerifyMobileNumberSectionState extends State<VerifyMobileNumberSection> {

  FocusNode _pinFocus = FocusNode();

  Timer _timer;
  int _timeCounter = 0;
  int _retryAfterSeconds = 60;

  @override
  void dispose() {
    try {
      _timer?.cancel();
    } catch (e) {
      print('dispose catch: $e');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CreateAccountModel>(context);

    return ContentLayout(
      onInit: () {
        Future.delayed(Duration(milliseconds: 400), () {
          if (!mounted) return;
          FocusScope.of(context).requestFocus(_pinFocus);
        });
      },
      title: 'Verification',
      subtitle: 'Enter the One Time Password sent to +63${model.accountCreation.mobileNumber}',
      child: Center(
        child: Column(
          children: <Widget>[
            PinCodeTextField(
              focusNode: _pinFocus,
              highlight: true,
              highlightColor: kPrimaryColor,
              defaultBorderColor: Colors.black54,
              hasTextBorderColor: Colors.black54,
              onDone: (String value) {
                Future.delayed(Duration(milliseconds: 400), () => widget.onNextTap());
              },
              pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
              pinBoxDecoration: ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
              pinTextStyle: Theme.of(context).textTheme.headline.copyWith(
                fontWeight: FontWeight.bold
              ),
              pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
              pinTextAnimatedSwitcherDuration: Duration(milliseconds: 200),
            ),
            SizedBox(height: 12.0),
            _buildOTPResend(),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPResend() {
    String text = 'Resend Code';
    if (_timeCounter > 0) {
      text = 'Resend Code ($_timeCounter)';
    }

    return Column(
      children: <Widget>[
        Text("Didn't receive the code?", style: Theme.of(context).textTheme.caption),
        FlatButton(
          child: Text(text),
          onPressed: _timeCounter > 0 ? null : _onResendOTPTap
        )
      ],
    );
  }

  void _onResendOTPTap() {
    showToast('Code was sent successfully');
    if (!mounted) return;
    setState(() => _timeCounter =_retryAfterSeconds - 1);

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() => _timeCounter = (_retryAfterSeconds - timer.tick) - 1);

      if (_timeCounter <= 0) {
        _timer.cancel();
      }
    });
  }
}