import 'package:flutter/material.dart';

import '../main.dart';

String? selectedTheme = themes[0];
List<String> themes = ["light", "dark", "neon", "falcon"];

class ThemeSetting extends StatefulWidget {
  late String text = "";
  late int themeNumber;
  final Future<void> onThemeChanged;
  final Future<void> getThemePrefs;

  ThemeSetting({
    required this.text,
    required this.themeNumber,
    required this.onThemeChanged,
    required this.getThemePrefs,
  });

  @override
  State<ThemeSetting> createState() => _ThemeSettingState();
}

class _ThemeSettingState extends State<ThemeSetting> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2, color: Colors.grey[200]!),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10, left: 15),
            child: Text(
              widget.text,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 15),
                child: Radio<String>(
                  value: themes[widget.themeNumber],
                  groupValue: selectedTheme,
                  onChanged: (String? value) {
                    setState(() {
                      selectedTheme = value!;
                    });
                    print(themes[widget.themeNumber]);
                    print(selectedTheme);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
