import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduledTaskSuccessPageWidget extends StatefulWidget {
  ScheduledTaskSuccessPageWidget({
    Key key,
    this.level,
    this.dueDate,
  }) : super(key: key);

  final dynamic level;
  final DateTime dueDate;

  @override
  _ScheduledTaskSuccessPageWidgetState createState() =>
      _ScheduledTaskSuccessPageWidgetState();
}

class _ScheduledTaskSuccessPageWidgetState
    extends State<ScheduledTaskSuccessPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                child: IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NavBarPage(initialPage: 'TaskListPage'),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.close,
                    color: FlutterFlowTheme.tertiaryColor,
                    size: 30,
                  ),
                  iconSize: 30,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'You\'re all set!',
                  style: FlutterFlowTheme.title1.override(
                    fontFamily: 'Playfair Display',
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getJsonField(widget.level, r'''$.fields.Name''')
                            .toString(),
                        style: FlutterFlowTheme.subtitle1.override(
                          fontFamily: 'Poppins',
                          color: FlutterFlowTheme.tertiaryColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(6, 0, 0, 0),
                        child: Text(
                          'practice planned for...',
                          style: FlutterFlowTheme.subtitle1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.tertiaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Text(
                    dateTimeFormat('MMMEd', widget.dueDate),
                    style: FlutterFlowTheme.title2.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NavBarPage(initialPage: 'TaskListPage'),
                        ),
                        (r) => false,
                      );
                    },
                    text: 'All done.',
                    options: FFButtonOptions(
                      width: 130,
                      height: 40,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
