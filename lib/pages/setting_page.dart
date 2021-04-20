import 'package:flutter/material.dart';
import 'package:ndi_new/models/user.dart';
import 'package:ndi_new/pages/drawer_page.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatefulWidget {
  final User? user;

  SettingPage({Key? key, this.user}) : super(key: key);

  @override
  _SettingState createState() => _SettingState(user: user);
}

class _SettingState extends State<SettingPage> {
  final User? user;
  final _advancedDrawerController = AdvancedDrawerController();

  _SettingState({this.user});

  @override
  Widget build(BuildContext context) {
    AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      child: SizedBox(),
      drawer: SizedBox(),
    );

    return AdvancedDrawer(
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Text('Setting'),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (context, value, child) {
                return Icon(
                  value.visible != null && value.visible!
                      ? Icons.clear
                      : Icons.menu,
                );
              },
            ),
          ),
        ),
        body: settingBody(),
      ),
      drawer: DrawerPage(user: user),
    );
  }

  Widget settingBody() {
    bool value = false;
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: SettingsList(
          backgroundColor: Colors.white,
          sections: [
            SettingsSection(
              title: 'Section',
              tiles: [
                SettingsTile(
                  title: 'Language',
                  subtitle: 'English',
                  leading: Icon(Icons.language),
                  onPressed: (BuildContext context) {},
                ),
                SettingsTile.switchTile(
                  title: 'Use fingerprint',
                  leading: Icon(Icons.fingerprint),
                  switchValue: value,
                  onToggle: (bool value) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
