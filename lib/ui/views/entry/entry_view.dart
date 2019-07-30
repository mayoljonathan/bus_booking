import 'package:bus_booking/core/helpers/utils.dart';
import 'package:bus_booking/core/helpers/validator.dart';
import 'package:bus_booking/core/viewmodels/user_model.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:bus_booking/core/config/constants.dart';
import 'package:bus_booking/ui/widgets/custom_ui.dart';
import 'package:bus_booking/ui/shared/theme.dart';
import 'package:provider/provider.dart';

class EntryView extends StatefulWidget {
  @override
  _EntryViewState createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> with TickerProviderStateMixin {

  KeyboardVisibilityNotification _keyboardVisibilityNotification = KeyboardVisibilityNotification();
  bool _isKeyboardVisible = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _showPassword = false;
  bool _isLoading = false;

  ScrollController _scrollController = ScrollController();
  TextEditingController _emailController = TextEditingController();

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
    _emailController.dispose();
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
              AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(
                  child: child,
                  scale: animation,
                ),
                child: _SubmitButton(
                  key: ValueKey<int>(_isLoading ? 1 : 0),
                  isLoading: _isLoading,
                  onPressed: _onSubmit
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        children: <Widget>[
          CustomTextField(
            controller: _emailController,
            focusNode: _emailFocus,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            labelText: 'Email Address',
            leftmostIcon: Icon(EvaIcons.emailOutline),
            validator: (value) => Validator([
              Validators().isRequired(value, 'Enter your email address'),
              Validators().isEmail(value, 'Enter your email address in correct format:\nsomeone@gmail.com')
            ]).exec(),
            onFieldSubmitted: (_) => Utils.fieldFocusChange(context, _emailFocus, _passwordFocus),
          ),
          SizedBox(height: 16.0),
          CustomTextField(
            focusNode: _passwordFocus,
            obscureText: !_showPassword,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            suffixIcon: IconButton(
              icon: Icon(_showPassword ? EvaIcons.eyeOffOutline : EvaIcons.eyeOutline),
              onPressed: () => setState(() => _showPassword = !_showPassword)
            ),
            labelText: 'Password',
            leftmostIcon: Icon(EvaIcons.lockOutline),
            validator: (value) => Validator([
              Validators().isRequired(value, 'Enter your password'),
              Validators().minLength(value, 6, 'Your password must be at least 6 characters')
            ]).exec(),
            onEditingComplete: _onSubmit
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() => _isLoading = false);

    if (this._formKey.currentState.validate()) {
      this._formKey.currentState.save();
      setState(() => _isLoading = true);

      Future.delayed(Duration(seconds: 2), () {
        final currentUser = Provider.of<UserModel>(context).currentUser;
        currentUser.emailAddress = _emailController.text;

        Navigator.pushReplacementNamed(context, '/main');
      });
    } else {
      setState(() => this._autoValidate = true);
    }
  }
}

class _SubmitButton extends StatelessWidget {

  const _SubmitButton({
    Key key,
    @required this.isLoading,
    @required this.onPressed
  }) : super(key: key);

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: key,
      heroTag: 'submit',
      onPressed: onPressed,
      child: !isLoading 
      ? Icon(EvaIcons.arrowForward) 
      : SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 2,
          )
        )
    );
  }
}