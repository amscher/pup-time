import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import '../scheduled_task_success_page/scheduled_task_success_page_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleTaskPageWidget extends StatefulWidget {
  ScheduleTaskPageWidget({
    Key key,
    this.level,
  }) : super(key: key);

  final dynamic level;

  @override
  _ScheduleTaskPageWidgetState createState() => _ScheduleTaskPageWidgetState();
}

class _ScheduleTaskPageWidgetState extends State<ScheduleTaskPageWidget> {
  DateTime datePicked;
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
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text(
                      'When do you want to practice...',
                      style: FlutterFlowTheme.subtitle1.override(
                        fontFamily: 'Poppins',
                        color: FlutterFlowTheme.tertiaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text(
                      getJsonField(widget.level, r'''$.fields.Name''')
                          .toString(),
                      style: FlutterFlowTheme.title2.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          onConfirm: (date) {
                            setState(() => datePicked = date);
                          },
                          currentTime: DateTime.now(),
                        );
                        final tasksCreateData = createTasksRecordData(
                          user: currentUserReference,
                          dueDate: datePicked,
                          createdDate: getCurrentTimestamp,
                          status: 'incomplete',
                          itemId: getJsonField(
                                  widget.level, r'''$.fields.Items[0]''')
                              .toString(),
                          levelId: getJsonField(widget.level, r'''$.id''')
                              .toString(),
                        );
                        await TasksRecord.collection.doc().set(tasksCreateData);
                        await Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ScheduledTaskSuccessPageWidget(
                              level: widget.level,
                            ),
                          ),
                          (r) => false,
                        );
                      },
                      text: 'Select Date',
                      options: FFButtonOptions(
                        width: 200,
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
            ),
          )
        ],
      ),
    );
  }
}
