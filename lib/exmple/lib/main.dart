import 'package:flutter/material.dart';
import 'package:grc_tab_bar/grc_tab_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('GRC Tab Bar Example')),
        body: GrcTabBar(
          tabs: const ['Tab 1', 'Tab 2', 'Tab 3'],
          content: [
            Center(child: Text('Content 1')),
            Center(child: Text('Content 2')),
            Center(child: Text('Content 3')),
          ],
          style: Style.rounded,
          tabBarAlignment:  TabBarAlignment.center,
        ),
      ),
    );
  }
}