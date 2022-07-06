import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'adaptiveDatePickerMode.dart';

/// A material widget for selecting a date or time.
///
/// A popup lets the user select a date or time. The widget
/// shows the currently selected value.
///
/// The [onChanged] callback should update a state variable that defines the
/// picker's value. It should also call [State.setState] to rebuild the
/// picker with the new value.
///
class MaterialDatePicker extends StatefulWidget {
  MaterialDatePicker(
      {Key? key,
      this.mode = AdaptiveDatePickerMode.date,
      required this.initialDate,
      required this.firstDate,
      required this.lastDate,
      required this.onChanged,
      this.textColor,
      this.backgroundColor,
      this.borderColor,
      this.borderWidth,
      this.cornerRadius,
      this.fontSize})
      : super(key: key);

  /// The initially selected date. It must either fall between these dates, or be equal to one of them.
  final DateTime initialDate;

  /// The earliest allowable date.
  final DateTime firstDate;

  /// The latest allowable date.
  final DateTime lastDate;

  /// Called when the user selects a date/time.
  final void Function(DateTime)? onChanged;

  /// Determines whether to use Date or Time selector popups.
  final AdaptiveDatePickerMode mode;

  /// The color to use when painting the text.
  final Color? textColor;

  /// The color to fill in the background of the picker.
  final Color? backgroundColor;

  /// The color to use when painting the bordr of the picker.
  final Color? borderColor;

  /// The border width.
  final double? borderWidth;

  /// The corner radius.
  final double? cornerRadius;

  /// The font size of the selected item text.
  final double? fontSize;

  @override
  State<MaterialDatePicker> createState() => _MaterialDatePickerState();
}

class _MaterialDatePickerState extends State<MaterialDatePicker> {
  static final dateFormat = DateFormat('MMM dd, yyyy');
  static final timeFormat = DateFormat('hh:mm a');
  var date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    date = widget.initialDate;
    final textStyle = TextStyle(
        color: widget.textColor ?? Colors.black,
        fontSize: widget.fontSize ?? 17,
        fontWeight: FontWeight.w400);

    final formattedText = widget.mode == AdaptiveDatePickerMode.date
        ? dateFormat.format(date)
        : timeFormat.format(date);

    return Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.cornerRadius ?? 8.0),
            side: BorderSide(
                color: widget.borderColor ?? Colors.transparent,
                width: widget.borderWidth ?? 0)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
            onTap: () async {
              if (widget.mode == AdaptiveDatePickerMode.time) {
                var t = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay(hour: date.hour, minute: date.minute));
                if (t != null && widget.onChanged != null) {
                  setState(() {
                    date = DateTime(
                        date.year, date.month, date.day, t.hour, t.minute);
                    widget.onChanged!(date);
                  });
                }
              } else {
                var d = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: widget.firstDate,
                    lastDate: widget.lastDate);
                if (d != null && widget.onChanged != null) {
                  setState(() => date = d);
                  widget.onChanged!(d);
                }
              }
            },
            child: Ink(
              color: widget.backgroundColor ?? Color(0xFFEAEAEB),
              child: Center(child: Text(formattedText, style: textStyle)),
            )));
  }
}
