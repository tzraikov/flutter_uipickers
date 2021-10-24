import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum UIDatePickerMode { time, date, dateAndTime }

/// A wrapper around the native iOS 14 UIDatePicker that allows
/// selecting a date, time or date and time.
///
/// A popup lets the user select from a number of items. The widget
/// shows the currently selected item.
///
/// The [onChanged] callback should update a state variable that defines the
/// picker's value. It should also call [State.setState] to rebuild the
/// picker with the new value.
///
class UIDatePicker extends StatefulWidget {
  const UIDatePicker(
      {Key? key,
      this.mode = UIDatePickerMode.date,
      this.date,
      this.minimumDate,
      this.maximumDate,
      this.textColor,
      this.tintColor,
      this.backgroundColor,
      this.borderColor,
      this.borderWidth,
      this.cornerRadius,
      this.fontSize,
      this.onChanged})
      : super(key: key);

  /// The initially selected date. It must either fall between these dates, or be equal to one of them.
  final DateTime? date;

  /// The earliest allowable date.
  final DateTime? maximumDate;

  /// The latest allowable date.
  final DateTime? minimumDate;

  /// Called when the user selects a date/time.
  final void Function(DateTime)? onChanged;

  /// Determines whether to use Date, Time or Date+Time selector popups.
  final UIDatePickerMode mode;

  /// The color to use when painting the text.
  final Color? textColor;

  /// The text color to use when the picker is highlighted.
  final Color? tintColor;

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
  State<UIDatePicker> createState() => _UIDatePickerState();
}

class _UIDatePickerState extends State<UIDatePicker> {
  MethodChannel? _channel;

  @override
  Widget build(BuildContext context) {
    const String viewType = 'FLDatePicker';
    Map<String, dynamic> creationParams = <String, dynamic>{
      "mode": widget.mode.index,
    };
    if (widget.date != null) {
      creationParams["date"] = widget.date?.toIso8601String();
    }
    if (widget.minimumDate != null) {
      creationParams["minimumDate"] = widget.minimumDate?.toIso8601String();
    }
    if (widget.maximumDate != null) {
      creationParams["maximumDate"] = widget.maximumDate?.toIso8601String();
    }
    if (widget.textColor != null) {
      creationParams["textColor"] = widget.textColor?.value.toRadixString(16);
    }
    if (widget.tintColor != null) {
      creationParams["tintColor"] = widget.tintColor?.value.toRadixString(16);
    }
    if (widget.backgroundColor != null) {
      creationParams["backgroundColor"] =
          widget.backgroundColor?.value.toRadixString(16);
    }
    if (widget.borderColor != null) {
      creationParams["borderColor"] =
          widget.borderColor?.value.toRadixString(16);
    }
    if (widget.borderWidth != null) {
      creationParams["borderWidth"] = widget.borderWidth;
    }
    if (widget.cornerRadius != null) {
      creationParams["cornerRadius"] = widget.cornerRadius;
    }
    if (widget.fontSize != null) {
      creationParams["fontSize"] = widget.fontSize;
    }

    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: (int id) {
        _channel = MethodChannel('FLDatePicker/$id');
        _channel?.setMethodCallHandler(_channelCallHandler);
      },
    );
  }

  Future<void> _channelCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'onChanged':
        String text = call.arguments as String;
        DateTime date = DateTime.parse(text);
        if (widget.onChanged != null) {
          widget.onChanged!(date);
        }
    }
  }
}
