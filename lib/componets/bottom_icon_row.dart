import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcr/screens/add_screen.dart';
import 'package:mcr/screens/chart_page.dart';
import 'package:mcr/screens/setting_page.dart';

class BottomIconsRow extends StatefulWidget {
  @override
  _BottomIconsRowState createState() => _BottomIconsRowState();
}

class _BottomIconsRowState extends State<BottomIconsRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingPage()));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.settings,
              size: 30,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddScreen(
                          goBackToFirstScreen: true,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "ADD\nFOOD",
              style: GoogleFonts.lato(
                color: Colors.white.withOpacity(0.3),
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChartPage(
                          setFromFirstScreen: 1,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.table_chart,
              size: 30,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
      ],
    ));
  }
}
