# GRC Tab Bar

A customizable animated tab bar widget for Flutter with multiple styling options and animations.

## Features

- Multiple tab position options (top/bottom, left/center/right/full)
- Customizable styles (rounded or basic)
- Smooth animations when switching tabs
- Fully customizable colors and gradients
- Flexible content area

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  grc_tab_bar: ^1.0.0
```

## Usage

```dart
import 'package:grc_tab_bar/grc_tab_bar.dart';

GrcTabBar(
  tabs: const ['Tab 1', 'Tab 2', 'Tab 3'],
  content: [
    Center(child: Text('Content 1')),
    Center(child: Text('Content 2')),
    Center(child: Text('Content 3')),
  ],
  style: GrcTabBarStyle.rounded,
  tabPositionXaxis: GrcTabPositionXaxis.center,
  animationDuration: const Duration(milliseconds: 500),
)
```

## Customization

| Parameter            | Description                          | Default Value |
|----------------------|--------------------------------------|---------------|
| `tabs`               | List of tab labels                  | Required      |
| `content`            | List of content widgets             | Required      |
| `style`              | Tab style (rounded/basic)           | `basic`       |
| `tabPositionXaxis`   | Horizontal position of tabs         | `left`        |
| `tabPositionYaxis`   | Vertical position of tabs           | `top`         |
| `activeTabBackground`| Background color of active tab      | `Colors.white`|
| `tabBackground`      | Background color of inactive tabs   | `Colors.black38`|
| `animationDuration`  | Duration of tab switch animation    | `300ms`       |
| `animationCurve`     | Animation curve                     | `Curves.easeInOut` |