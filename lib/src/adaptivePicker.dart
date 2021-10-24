import 'package:flutter/material.dart';
import 'uipicker.dart';
import 'materialPicker.dart';

enum AdaptivePickerType { adaptive, material, cupertino }

/// An adaptive widget for selecting from a list of string items.
///
/// A dropdown menu lets the user select from a number of items. The widget
/// shows the currently selected item.
///
/// When used on iOS and when its type is set to adaptive or cupertino, it will show
/// a native UIMenu with a list of options.
///
/// When used on any other operating system or when the type is set to material, it
/// will use DropDownButton to present a list of options.
///
/// The [onChanged] callback should update a state variable that defines the
/// dropdown's value. It should also call [State.setState] to rebuild the
/// dropdown with the new value.
///
class AdaptivePicker extends StatelessWidget {
  AdaptivePicker(
      {Key? key,
      required this.items,
      this.value,
      this.onChanged,
      this.textColor,
      this.tintColor,
      this.backgroundColor,
      this.borderColor,
      this.borderWidth,
      this.cornerRadius,
      this.fontSize,
      this.textAlignment,
      this.type = AdaptivePickerType.adaptive})
      : super(key: key);

  /// The index of the currently selected item. Null if nothing is selected.
  final int? value;

  /// The list of string items the user can select.
  final List<String> items;

  /// Called when the user selects an item.
  final void Function(int?)? onChanged;

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

  /// The alignment to use for the selected item text.
  final PickerTextAlignment? textAlignment;

  /// The picker type to use. It is adaptive by default.
  /// When set to cupertino or adaptive it will instantinate a native platform picker when used with iOS.
  final AdaptivePickerType type;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    if (type != AdaptivePickerType.material &&
        theme.platform == TargetPlatform.iOS) {
      return _buildCupertinoNativePicker();
    }
    return _buildMaterialPicker();
  }

  Widget _buildCupertinoNativePicker() {
    return UIPicker(
      items: items,
      selectedIndex: value ?? -1,
      onChanged: onChanged,
      textColor: textColor,
      tintColor: tintColor,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      cornerRadius: cornerRadius,
      fontSize: fontSize,
      textAlignment: textAlignment,
    );
  }

  Widget _buildMaterialPicker() {
    return MaterialPicker(
      value: value,
      items: items,
      onChanged: onChanged,
      textColor: textColor,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      cornerRadius: cornerRadius,
      fontSize: fontSize,
      textAlignment: getAlignmentGeometry(),
    );
  }

  AlignmentGeometry? getAlignmentGeometry() {
    if (textAlignment != null) {
      switch (textAlignment) {
        case PickerTextAlignment.left:
          return Alignment.centerLeft;
        case PickerTextAlignment.right:
          return Alignment.centerRight;
        default:
          return AlignmentDirectional.center;
      }
    }
    return null;
  }
}
