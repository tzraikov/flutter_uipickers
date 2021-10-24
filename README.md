# uipickers

A plugin library that exposes platform specific date, time and picker popups. It uses the native iOS 14 UIKit [UIDatePicker](https://developer.apple.com/documentation/uikit/uidatepicker) and SwiftUI like [Picker](https://developer.apple.com/documentation/swiftui/picker) on iOS and the corresponding material pickers on other platforms.

![Image 1](https://github.com/tzraikov/flutter_uipickers/blob/main/screenshots/1.png "Image 1")
![Image 2](https://github.com/tzraikov/flutter_uipickers/blob/main/screenshots/2.png "Image 2")

## Usage

First import it in your Dart code:

```dart
import 'package:uipickers/uipickers.dart';
```

Then select one of the following widgets:

- [AdaptiveDatePicker](#AdaptiveDatePicker) - Allows selecting a date or time and displays the selected date in a widget. The underlying popup is selected automatically based on the current platform.
- [AdaptivePicker](#AdaptivePicker) - Allows selecting an item from a list of string items. The underlying popup is selected automatically based on the current platform.
- [UIDatePicker](#AdaptiveDatePicker) - Allows selecing a date, time, or time+date and uses a native iOS 14 style UIDatePicker component. 
- [UIPicker](#AdaptivePicker) - Allows selecting an item from a list of string items. Uses iOS native components (UIButton + UIMenu) to present SwiftUI like Picker popup.
- [MaterialDatePicker](#AdaptiveDatePicker) - Allows selecing a date, time, or time+date and uses the build-in material dialogs.
- [MaterialPicker](#AdaptivePicker) - Allows selecing an item from a list of string items. Uses the build-in DropDownButton.

## AdaptiveDatePicker

The **AdaptiveDatePicker** is used for selecting a date or time. It displays the currently selected date/time in its widget. On iOS it will use a native iOS 14 style UIDatePicker. The **initialDate** property sets the currently selected date, **firstDate** is the earliest allowable date and **lastDate** is the  latest allowable date. The **onChanged** event handler is called when the user selects an item from the popup:

```dart
DateTime selectedDate = DateTime.now();
//...
AdaptiveDatePicker(
    initialDate: selectedDate,
    firstDate: DateTime.now(), 
    lastDate: DateTime.now().add(Duration(days: 10)),
    onChanged: (date) { setState(() => selectedDate = date); },
)
```

> **_Warning:_** The size of the widget should be constrained. For example it could be wrapped inside a **SizedBox**:

```dart
SizedBox(width: 150, height: 34,
    child: AdaptiveDatePicker(
        //...
    )
)
```

In order to use the native version explicitly, just set the **type** property to **cupertino**, or replace **AdaptiveDatePicker** with **UIDatePicker**:

```dart
AdaptiveDatePicker(
    type: AdaptiveDatePickerType.cupertino,
    //...
)
```

The **tintColor** property is specific for **UIDatePicker**. It changes the highlighted text color: 

```dart
UIDatePicker(
    tintColor: UIColors.red,
    //...
)
```

There are various attributes to customize, for example **backgroundColor**, **cornerRadius**, **borderColor**, etc.:

```dart
AdaptiveDatePicker(
    backgroundColor: Colors.blue[50]!,
    borderColor: Colors.blue[800]!,
    borderWidth: 3,
    cornerRadius: 4,
    items: items, 
    value: selectedItem, 
    onChanged: (value) { setState(() => selectedItem = value); },
);
```

## AdaptivePicker

The **AdaptivePicker** widget allows automatic selection of the underlying widget implementation based on the operating system. On iOS it will use a SwiftUI like picker based on UIButton+UIMenu. The **value** property sets the currently selected item index, and the **onChanged** event handler is called when the user selects an item from the popup:

```dart
int selectedItem = 1;
var items = [ 'one', 'two', 'three' ];
//...
AdaptivePicker(
    items: items, 
    value: selectedItem, 
    onChanged: (value) { setState(() => selectedItem = value); }
)
```

> **_Warning:_** The size of the widget should be constrained. For example it could be wrapped inside a **SizedBox**:

```dart
SizedBox(width: 150, height: 34,
    child: AdaptiveDatePicker(
        //...
    )
)
```

In order to use the native version explicitly, just set the **type** property to **cupertino**, or replace **AdaptivePicker** with **UIPicker**:

```dart
AdaptivePicker(
    type: AdaptivePickerType.cupertino,
    //...
)
```

There are various attributes to customize, for example **backgroundColor**, **cornerRadius**, **borderColor**, etc.:

```dart
UIPicker(
    backgroundColor: Colors.blue[50]!,
    borderColor: Colors.blue[800]!,
    borderWidth: 3,
    cornerRadius: 4,
    items: items, 
    value: selectedItem, 
    onChanged: (value) { setState(() => selectedItem = value); },
);
```
