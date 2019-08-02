import 'package:bus_booking/core/config/constants.dart';
import 'package:bus_booking/core/viewmodels/create_account_model.dart';
import 'package:bus_booking/core/viewmodels/user_model.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:bus_booking/ui/widgets/custom_ui.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'content_layout.dart';

class CreateAccountSuccessView extends StatelessWidget {
  CreateAccountSuccessView({
    @required this.model
  });

  final CreateAccountModel model;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      body: CustomSliverBody(
        leading: IconButton(
          icon: Icon(EvaIcons.closeOutline),
          onPressed: () => Navigator.pop(context),
        ),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ContentLayout(
                title: _buildTitle(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Hello ${model.accountCreation.displayName}!', style: themeData.textTheme.display1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor
                    )),
                    SizedBox(height: 24.0),
                    RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        style: themeData.textTheme.subhead,
                        text: 'Welcome to ',
                        children: [
                          TextSpan(
                            text: '$APP_NAME',
                            style: themeData.textTheme.subhead.copyWith(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor
                            )
                          ),
                          TextSpan(text: ' !')
                        ]
                      ),
                    ),
                    SizedBox(height: 3.0),
                    Text('You can now start booking a bus.', style: themeData.textTheme.subhead),
                    SizedBox(height: 24.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton.extended(
                        label: Text('Get Started', style: themeData.textTheme.button),
                        heroTag: 'submit',
                        onPressed: () => _onGetStartedTap(context),
                      ),
                    )
                  ],
                )
              ),
            )
          ),
        ]
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: kPrimaryColor,
          width: 2
        )
      ),
      child: Icon(EvaIcons.personOutline, 
        color: kPrimaryColor,
        size: 56.0
      ),
    );
  }

  void _onGetStartedTap(context) {
    final currentUser = Provider.of<UserModel>(context).currentUser;

    currentUser.displayName = model.accountCreation.displayName;
    currentUser.emailAddress = model.accountCreation.emailAddress;
    currentUser.mobileNumber = model.accountCreation.mobileNumber;

    Navigator.pushReplacementNamed(context, '/main');
  }
}