import 'package:Survey_App/Pages/LoginPage.dart';
import 'package:Survey_App/Pages/SingupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/typography.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Page imports
import '../Pages/HomePage.dart';
import '../Pages/NotificationPage.dart';
import '../Pages/SearchPage.dart';
import '../Pages/SettingsPage.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    BottomNavigationBar customNavigationBar = new BottomNavigationBar(
      // backgroundColor: Colors.transparent,
      currentIndex: _currentIndex,
      elevation: 2,
      selectedItemColor: Colors.blue,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedFontSize: 12,
      selectedLabelStyle: TextStyle(color: Colors.blue[900]),
      onTap: _onTap,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icons/home_o.svg",
            height: 20,
            width: 20,
            color: primary,
          ),
          activeIcon: SvgPicture.asset(
            "assets/icons/home_s.svg",
            height: 20,
            width: 20,
            color: primary,
          ),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: Colors.blue,
          ),
          activeIcon: SvgPicture.asset(
            "assets/icons/search_s.svg",
            height: 20,
            width: 20,
            color: primary,
          ),
          title: Text("Home"),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icons/bell_s.svg",
            height: 20,
            width: 20,
            color: primary,
          ),
          activeIcon: SvgPicture.asset(
            "assets/icons/bell_o.svg",
            height: 20,
            width: 20,
            color: primary,
          ),
          title: Text("Notification"),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/icons/gear_o.svg",
            height: 20,
            width: 20,
            color: primary,
          ),
          activeIcon: SvgPicture.asset(
            "assets/icons/gear_s.svg",
            height: 20,
            width: 20,
            color: primary,
          ),
          title: Text("Setting"),
        ),
      ],
    );
    return WillPopScope(
      onWillPop: _onBackButtonPress,
      child: Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: [
              HomePage(),
              SearchPage(),
              NotificationPage(),
              SettingsPage(),
            ],
          ),
          bottomNavigationBar: customNavigationBar),
    );
  }

  _onTap(int tabIndex) {
    // switch (tabIndex) {
    //   case 0:
    //     navigatorKey.currentState.pushNamed("Home");
    //     break;
    //   case 1:
    //     navigatorKey.currentState.pushNamed("Search");
    //     break;
    //   case 2:
    //     navigatorKey.currentState.pushNamed("Notification");
    //     break;
    //   case 3:
    //     navigatorKey.currentState.pushNamed("Setting");
    //     break;
    //   default:
    //     navigatorKey.currentState.pushNamed("Home");
    // }
    setState(() {
      _currentIndex = tabIndex;
    });
  }

  Future<bool> _onBackButtonPress() async {
    if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
    } else {
      SystemNavigator.pop();
    }
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "Home":
        return MaterialPageRoute(builder: (context) => HomePage());
      case "Search":
        return MaterialPageRoute(builder: (context) => SearchPage());
      case "Notification":
        print(2);
        return MaterialPageRoute(builder: (context) => NotificationPage());
      case "Setting":
        return MaterialPageRoute(builder: (context) => SettingsPage());
      default:
        return MaterialPageRoute(builder: (context) => HomePage());
    }
  }
}