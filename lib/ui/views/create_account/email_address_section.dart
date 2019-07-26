import 'package:bus_booking/core/helpers/validator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'content_layout.dart';
import 'create_account_model.dart';

class EmailAddressSection extends StatefulWidget {
  const EmailAddressSection({
    this.onBackTap,
    this.onNextTap
  });

  final VoidCallback onBackTap;
  final VoidCallback onNextTap;

  @override
  _EmailAddressSectionState createState() => _EmailAddressSectionState();
}

class _EmailAddressSectionState extends State<EmailAddressSection> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode _emailFocus = FocusNode();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return ContentLayout(
      onInit: () {
        Future.delayed(Duration(milliseconds: 400), () {
          FocusScope.of(context).requestFocus(_emailFocus);
        });
      },
      title: "What's your email address?",
      subtitle: 'This will served as your login credential',
      child: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          children: <Widget>[
            TextFormField(
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              style: themeData.textTheme.title,
              decoration: InputDecoration(
                hintText: 'someone@gmail.com',
              ),
              validator: (value) => Validator([
                Validators().isRequired(value, 'Enter your email address'),
                Validators().isEmail(value, 'Enter your email address in correct format:\nsomeone@gmail.com')
              ]).exec(),
              initialValue: Provider.of<CreateAccountModel>(context).accountCreation.emailAddress ?? '',
              onChanged: (String value) {
                Provider.of<CreateAccountModel>(context).accountCreation.emailAddress = value;
              },
              onEditingComplete: _onSubmit,
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(EvaIcons.arrowBack),
                  onPressed: widget.onBackTap,
                ),
                SizedBox(width: 12.0),
                FloatingActionButton(
                  heroTag: 'submit',
                  child: Icon(EvaIcons.arrowForward),
                  onPressed: _onSubmit,
                ),
              ],
            )
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