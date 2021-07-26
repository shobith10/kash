import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kash/sign.dart';
import 'package:settings_ui/settings_ui.dart';

class Setting extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Setting> {
  int value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
            'Settings',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Center(
          child: SettingsList(
            sections: [
              SettingsSection(
                subtitlePadding: const EdgeInsets.symmetric(horizontal: 30,vertical: 40),
                title: 'General',
                tiles: [
                  SettingsTile(
                    title: 'Language',
                    subtitle: 'English',
                    leading: Icon(Icons.language),
                    onPressed: (BuildContext context) {},
                  ),
                  SettingsTile(
                    title: 'Theme',
                    leading: Icon(Icons.bedtime_outlined),
                    //switchValue: value,
                    onPressed: (value) {
                    },
                  ),
                  SettingsTile(
                    title: 'Notifications',
                    leading: Icon(Icons.notifications),
                    //switchValue: value,
                    onPressed: (value) {
                    },
                  ),

                ],

              ),
            ],

          )
        ),
      ),

    );
  }
}
