import 'package:bus_booking/core/helpers/validator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'content_layout.dart';
import 'create_account_model.dart';

class PasswordSection extends StatefulWidget {
  const PasswordSection({
    this.onBackTap,
    this.onNextTap
  });

  final VoidCallback onBackTap;
  final VoidCallback onNextTap;

  @override
  _PasswordSectionState createState() => _PasswordSectionState();
}

class _PasswordSectionState extends State<PasswordSection> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode _passwordFocus = FocusNode();
  bool _autoValidate = false;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return ContentLayout(
      onInit: () {
        Future.delayed(Duration(milliseconds: 400), () {
          FocusScope.of(context).requestFocus(_passwordFocus);
        });
      },
      title: 'Make your password',
      subtitle: 'To keep your account safe',
      child: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          children: <Widget>[
            TextFormField(
              focusNode: _passwordFocus,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              style: themeData.textTheme.title,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                hintText: 'your awesome password',
                suffixIcon: IconButton(
                  icon: Icon(_showPassword ? EvaIcons.eyeOffOutline : EvaIcons.eyeOutline),
                  onPressed: () => setState(() => _showPassword = !_showPassword)
                )
              ),
              validator: (value) => Validator([
                Validators().isRequired(value, 'Enter your password'),
                Validators().minLength(value, 6, 'Your password must be at least 6 characters')
              ]).exec(),
              initialValue: Provider.of<CreateAccountModel>(context).accountCreation.password ?? '',
              onChanged: (String value) {
                Provider.of<CreateAccountModel>(context).accountCreation.password = value;
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