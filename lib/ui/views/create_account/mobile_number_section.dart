import 'package:bus_booking/core/helpers/validator.dart';
import 'package:bus_booking/core/models/account_creation.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'content_layout.dart';
import 'create_account_model.dart';

class MobileNumberSection extends StatefulWidget {
  const MobileNumberSection({
    this.onNextTap
  });

  final VoidCallback onNextTap;

  @override
  _MobileNumberSectionState createState() => _MobileNumberSectionState();
}

class _MobileNumberSectionState extends State<MobileNumberSection> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  FocusNode _mobileNumberFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ContentLayout(
      onInit: () {
        Future.delayed(Duration(milliseconds: 400), () {
          FocusScope.of(context).requestFocus(_mobileNumberFocus);
        });
      },
      title: 'Enter your mobile number',
      subtitle: 'We will send you a One Time Password on this mobile number',
      child: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          children: <Widget>[
            TextFormField(
              focusNode: _mobileNumberFocus,
              style: Theme.of(context).textTheme.title,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixText: '+63',
              ),
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10)
              ],
              validator: (value) => Validator([
                Validators().isRequired(value, 'Enter your mobile number'),
                Validators().minLength(value, 10, 'Enter a 10-digit mobile number'),
              ]).exec(),
              initialValue: Provider.of<CreateAccountModel>(context).accountCreation.mobileNumber ?? '',
              onChanged: (String value) {
                Provider.of<CreateAccountModel>(context).accountCreation.mobileNumber = value;
              },
              onEditingComplete: _onSubmit
            ),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                heroTag: 'submit',
                child: Icon(EvaIcons.arrowForward),
                onPressed: this._onSubmit
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    if (this._formKey.currentState.validate()) {
      this._formKey.currentState.save();
      widget.onNextTap();
    } else {
      setState(() => this._autoValidate = true);
    }
  }
}