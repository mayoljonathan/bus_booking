import 'package:bus_booking/core/helpers/validator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'content_layout.dart';
import 'create_account_model.dart';

class NameSection extends StatefulWidget {
  const NameSection({
    this.onBackTap,
    this.onNextTap
  });

  final VoidCallback onBackTap;
  final VoidCallback onNextTap;

  @override
  _NameSectionState createState() => _NameSectionState();
}

class _NameSectionState extends State<NameSection> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode _nameFocus = FocusNode();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return ContentLayout(
      onInit: () {
        Future.delayed(Duration(milliseconds: 400), () {
          FocusScope.of(context).requestFocus(_nameFocus);
        });
      },
      title: "And lastly, how should I call you?",
      subtitle: 'Your nickname or first name will do',
      child: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Column(
          children: <Widget>[
            TextFormField(
              focusNode: _nameFocus,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              style: themeData.textTheme.title,
              decoration: InputDecoration(
                hintText: 'your name',
              ),
              validator: (value) => Validator([
                Validators().isRequired(value, 'Nah, enter your name'),
              ]).exec(),
              initialValue: Provider.of<CreateAccountModel>(context).accountCreation.displayName ?? '',
              onChanged: (String value) {
                Provider.of<CreateAccountModel>(context).accountCreation.displayName = value;
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