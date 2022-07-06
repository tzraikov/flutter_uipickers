import 'package:flutter/material.dart';

/// A material widget for selecting from a list of items.
/// Internally it uses the DropDownButton widget.
///
/// A dropdown menu lets the user select from a number of string items. The widget
/// shows the currently selected item.
///
/// The [onChanged] callback should update a state variable that defines the
/// dropdown's value. It should also call [State.setState] to rebuild the
/// dropdown with the new value.
///
class MaterialPicker extends StatefulWidget {
  MaterialPicker(
      {Key? key,
      required this.value,
      required this.items,
      required this.onChanged,
      this.textColor,
      this.backgroundColor,
      this.dropDownItemTextColor,
      this.borderWidth,
      this.borderColor,
      this.cornerRadius,
      this.fontSize,
      this.textAlignment})
      : super(key: key);

  /// The index of the currently selected item. Null if nothing is selected.
  final int? value;

  /// The list of string items the user can select.
  final List<String> items;

  /// Called when the user selects an item.
  final void Function(int)? onChanged;

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

  /// The alignment to use for the selected item text.
  final AlignmentGeometry? textAlignment;

  /// The color to use when painting the text in a drop down item.
  final Color? dropDownItemTextColor;

  @override
  State<MaterialPicker> createState() => _MaterialPickerState();
}

class _MaterialPickerState extends State<MaterialPicker> {
  var selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    selectedIndex = widget.value ?? -1;
    return Container(
        decoration: BoxDecoration(
            color: widget.backgroundColor ?? Color(0xFFEAEAEB),
            borderRadius: BorderRadius.circular(widget.cornerRadius ?? 8),
            border: Border.all(
                color: widget.borderColor ?? Colors.transparent,
                width: widget.borderWidth ?? 0)),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: DropdownButton<int>(
          selectedItemBuilder: _buildSelectedItems,
          value: widget.value,
          underline: Container(),
          iconSize: 0,
          menuMaxHeight: 400,
          style: TextStyle(
              fontSize: widget.fontSize ?? 17,
              color: widget.textColor ?? Colors.black),
          items: _buildLabels(widget.items),
          isExpanded: true,
          onChanged: (value) {
            setState(() => selectedIndex = value ?? -1);
            if (widget.onChanged != null) widget.onChanged!(value ?? -1);
          },
        ));
  }

  List<Widget> _buildSelectedItems(BuildContext context) {
    return widget.items.map<Widget>((String item) {
      return Container(
          alignment: widget.textAlignment ?? Alignment.centerLeft,
          child: Text(item, textAlign: TextAlign.end));
    }).toList();
  }

  List<DropdownMenuItem<int>> _buildLabels(List<String> items) {
    var color = widget.dropDownItemTextColor != null
        ? widget.dropDownItemTextColor
        : Colors.black;
    var style = TextStyle(color: color);
    var result = <DropdownMenuItem<int>>[];
    var i = 0;
    for (var item in items) {
      result.add(DropdownMenuItem<int>(
        child: Text(item, style: style),
        value: i++,
      ));
    }
    return result;
  }
}
