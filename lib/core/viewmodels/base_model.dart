import 'package:flutter/widgets.dart';

/// Represents the state of the view
enum ViewState { IDLE, BUSY }

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.IDLE;
  ViewState get state => _state;
  void setViewState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}