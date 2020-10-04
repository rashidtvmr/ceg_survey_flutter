import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Survey_App/models/app.dart';
// import 'package:Survey_App/Pages/HomePage.dart';
import 'package:Survey_App/Pages/LoginPage.dart';
import 'package:Survey_App/Pages/SingupPage.dart';
import 'package:Survey_App/Pages/AboutUsPage.dart';
import 'package:Survey_App/Pages/HelpPage.dart';
import 'package:Survey_App/Pages/NotificationSettingPage.dart';
import 'package:Survey_App/widget/LargeButton.dart';
import '../models/typography.dart';
import '../models/app.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void goToAnotherPage(String pageName) {
    if (pageName == 'login') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => LoginPage()));
    } else if (pageName == 'signup') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
    } else if (pageName == 'notification') {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => NotificationSettingPage()));
    } else if (pageName == 'help') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HelpPage()));
    } else if (pageName == 'about') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => AboutUSPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Consumer<AppModel>(
            builder: (context, app, child) => Column(
              children: [
                defaultHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: app.getAuth
                          ? Text(
                              app.getUserName.split("")[0],
                              style: TextStyle(fontSize: 50),
                            )
                          : Icon(
                              Icons.supervised_user_circle,
                              size: 100,
                            ),
                      // backgroundImage: AssetImage('assets/images/me.jpg'),
                      maxRadius: 50,
                    )
                  ],
                ),
                defaultHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      app.getUserName,
                      style: defaultTextStyle,
                    )
                  ],
                ),
                defaultHeight,
                Row(
                  children: [
                    Text('Account', style: secondaryTextStyle),
                  ],
                ),
                Consumer<AppModel>(
                  builder: (context, app, child) => Column(
                    children: [
                      LargeButton(
                        app.getAuth ? " Logout" : "Login",
                        app.getAuth ? Icons.error_outline : Icons.person,
                        () => {
                          app.getAuth
                              ? app.authenticate(false)
                              : goToAnotherPage("login")
                        },
                      ),
                      app.getAuth
                          ? Container()
                          : LargeButton(
                              "Signup",
                              Icons.person_add,
                              () => {
                                goToAnotherPage("signup"),
                              },
                            ),
                    ],
                  ),
                ),
                defaultHeight,
                Row(
                  children: [
                    Text('General', style: secondaryTextStyle),
                  ],
                ),
                Column(
                  children: [
                    LargeButton(
                      "Notification",
                      Icons.notifications,
                      () => {goToAnotherPage("notification")},
                    ),
                  ],
                ),
                defaultHeight,
                Row(
                  children: [
                    Text('Other', style: secondaryTextStyle),
                  ],
                ),
                Column(
                  children: [
                    LargeButton(
                      "Help",
                      Icons.live_help,
                      () => {goToAnotherPage("help")},
                    ),
                    LargeButton(
                      "About US",
                      Icons.group,
                      () => {
                        goToAnotherPage("about"),
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
