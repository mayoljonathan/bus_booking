part of '../custom_ui.dart';

class CustomDatePicker extends StatefulWidget {
  CustomDatePicker({
    this.headerTitle,
    this.confirmText,
    this.onConfirmTap,
    this.mode = CupertinoDatePickerMode.dateAndTime,
    this.onDateTimeChanged,
    DateTime initialDateTime,
    this.maximumDate,
    this.maximumYear,
    this.minimumDate,
    this.minimumYear,
    this.minuteInterval = 1,
    this.use24hFormat = false
  }) : initialDateTime = initialDateTime ?? DateTime.now();

  final String headerTitle;
  final String confirmText;
  final Function(DateTime) onConfirmTap;

  final CupertinoDatePickerMode mode;
  final ValueChanged<DateTime> onDateTimeChanged;
  final DateTime initialDateTime;
  final DateTime maximumDate;
  final int maximumYear;
  final DateTime minimumDate;
  final int minimumYear;
  final int minuteInterval;
  final bool use24hFormat;

  @override
  CustomDatePickerState createState() => CustomDatePickerState();
}

class CustomDatePickerState extends State<CustomDatePicker> {

  DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    this._selectedDateTime = widget.initialDateTime ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildHeader(),
          _buildDatePicker(),
          _buildConfirm()
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (widget.headerTitle == null) return Container();
    return Container(
      margin: const EdgeInsets.only(left: 12.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(widget.headerTitle, style: Theme.of(context).textTheme.title),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )  
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    if (widget.initialDateTime.year > widget.minimumYear) this._selectedDateTime = widget.initialDateTime;
    
    return Container(
      height: 250,
      child: CupertinoDatePicker(
        mode: widget.mode,
        onDateTimeChanged: widget.onDateTimeChanged ?? (DateTime dt) => this._selectedDateTime = dt,
        initialDateTime: this._selectedDateTime,
        maximumDate: widget.maximumDate,
        maximumYear: widget.maximumYear,
        minimumDate: widget.minimumDate,
        minimumYear: widget.minimumYear,
        minuteInterval: widget.minuteInterval,
        use24hFormat: widget.use24hFormat,
      )
    );
  }

  Widget _buildConfirm() {
    if (widget.onConfirmTap == null || widget.confirmText == null) return Container();

    return Container(
      height: 48,
      margin: const EdgeInsets.all(12.0),
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: () {
          Navigator.pop(context);
          widget.onConfirmTap(this._selectedDateTime);
        },
        child: Text(widget.confirmText, style: TextStyle(
          fontSize: 16.0
        )),
      ),
    );
  }
}