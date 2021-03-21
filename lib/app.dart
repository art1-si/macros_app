import 'package:flutter/material.dart';
import 'package:mcr/logic/day_selector_model.dart';
import 'package:mcr/logic/just_rebuild.dart';
import 'package:mcr/logic/theme_menager.dart';
import 'package:mcr/logic/total_provder.dart';
import 'package:mcr/screens/chart_page.dart';
import 'package:mcr/screens/first_screen.dart';
import 'package:mcr/screens/user_page.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  final int selectedPageindexFromOutSide;
  MyApp({this.selectedPageindexFromOutSide});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static List<Widget> _widgetOptions = <Widget>[
    UserPage(),
    FirstScreen(),
    ChartPage(),
  ];

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MultiProvider(
      providers: [
        Provider<DaySelectorModel>(create: (context) => DaySelectorModel()),
        ChangeNotifierProvider<TotalMacroProvider>(
            create: (context) => TotalMacroProvider(0, 0, 0, 0)),
        ChangeNotifierProvider<JustRebuild>(create: (context) => JustRebuild()),
      ],
      child: MaterialApp(
        theme: themeNotifier.getTheme(),
        home: Center(
          child: Container(
            color: Color(0xff07141C),
            child: SafeArea(
              child: Scaffold(
                body: _widgetOptions[_selectedIndex],
                bottomNavigationBar: Stack(
                  children: <Widget>[
                    BottomNavigationBar(
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Colors.white.withOpacity(0.5),
                      elevation: 0,
                      items: [
                        BottomNavigationBarItem(
                          label: 'User',
                          icon: Icon(
                            LineIcons.user,
                          ),
                        ),
                        BottomNavigationBarItem(
                          label: 'Home',
                          icon: Icon(
                            LineIcons.home,
                          ),
                        ),
                        BottomNavigationBarItem(
                          label: 'Charts',
                          icon: Icon(
                            LineIcons.pie_chart,
                          ),
                        ),
                      ],
                      currentIndex: _selectedIndex,
                      onTap: _onItemTapped,
                    ),
                    Container(
                      height: 1,
                      color: Color(0xff090D14).withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
