import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkModeEnabled = false; // Track dark mode state

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: Center(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.black.withOpacity(0.95) : Colors.white,
          ),
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              children: [
                ListTile(
                  title: Text(
                    'Dark Mode',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  trailing: Switch(
                    value: _darkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        _darkModeEnabled = value;
                        // TODO: Implement dark mode toggle logic here
                      });
                    },
                  ),
                ),
                Divider(height: 1, thickness: 1),
                // Add other settings options here
                ListTile(
                  title: Text(
                    'Share the app',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  onTap: () {
                    // TODO: Implement action for option 1
                  },
                ),
                Divider(height: 1, thickness: 1),
                ListTile(
                  title: Text(
                    'Term and conditions',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  onTap: () {
                    // TODO: Implement action for option 2
                  },
                ),
                Divider(height: 1, thickness: 1),
                // Add more settings options as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}
