import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestingWidget extends StatefulWidget {
  TestingWidget({Key key}) : super(key: key);

  @override
  _TestingWidgetState createState() => _TestingWidgetState();
}

class _TestingWidgetState extends State<TestingWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [],
          )
        ],
      ),
    );
  }
}
