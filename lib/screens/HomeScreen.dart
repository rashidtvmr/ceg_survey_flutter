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
  int _currentIndex = 0;
  PageController _controller = PageController(
    initialPage: 0,
  );
  void pageChanged(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BottomNavigationBar customNavigationBar = new BottomNavigationBar(
      // backgroundColor: Colors.transparent,
      currentIndex: _currentIndex,
      elevation: 10,
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
          body: PageView(
            onPageChanged: pageChanged,
            controller: _controller,
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
      print(tabIndex);
      _controller.jumpToPage(tabIndex);
      _currentIndex = tabIndex;
    });
  }

  Future<bool> _onBackButtonPress() async {
    if (_currentIndex != 0) {
      setState(() {
        _controller.jumpTo(0);
        _currentIndex = 0;
      });
    } else {
      print("exiting...");
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text("Do you want to exit?"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          actions: [
            FlatButton(
              child: Text("No"),
              onPressed: () => {Navigator.of(context).pop()},
            ),
            RaisedButton(
              color: primary,
              child: Text("Yes"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () => SystemNavigator.pop(),
            ),
          ],
        ),
      );
      // SystemNavigator.pop();
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
