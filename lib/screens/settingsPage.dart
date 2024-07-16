import 'package:ebook_app/Providers/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

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
                  trailing: Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                      return Switch(
                        activeTrackColor: Colors.orange,
                        activeColor: Colors.white,
                        value: themeProvider.isDarkMode,
                        onChanged: (value) {
                          themeProvider.setIsDarkMode(value);
                        },
                      );
                    },
                  ),
                ),
                Divider(height: 1, thickness: 1),
                // Add other settings options here
                ListTile(
                  title: Text(
                    'Terms & conditions',
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
                    'Share the App',
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
