import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LevelPageWidget extends StatefulWidget {
  LevelPageWidget({
    Key key,
    this.level,
    this.task,
  }) : super(key: key);

  final dynamic level;
  final TasksRecord task;

  @override
  _LevelPageWidgetState createState() => _LevelPageWidgetState();
}

class _LevelPageWidgetState extends State<LevelPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PracticeIterationsRecord>>(
      stream: queryPracticeIterationsRecord(
        queryBuilder: (practiceIterationsRecord) => practiceIterationsRecord
            .where('user', isEqualTo: currentUserReference)
            .where('level_id',
                isEqualTo: getJsonField(widget.level, r'''$.id''').toString()),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: LinearProgressIndicator(
              color: FlutterFlowTheme.primaryColor,
            ),
          );
        }
        List<PracticeIterationsRecord> levelPagePracticeIterationsRecordList =
            snapshot.data;
        // Customize what your widget looks like with no query results.
        if (snapshot.data.isEmpty) {
          return Material(
            child: Container(
              height: 100,
              child: Center(
                child: Text('No results.'),
              ),
            ),
          );
        }
        final levelPagePracticeIterationsRecord =
            levelPagePracticeIterationsRecordList.first;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            leading: InkWell(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 24,
              ),
            ),
            title: Text(
              getJsonField(widget.level, r'''$.fields.Name''').toString(),
              style: FlutterFlowTheme.bodyText2.override(
                fontFamily: 'Playfair Display',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [],
            centerTitle: true,
            elevation: 0,
          ),
          backgroundColor: FlutterFlowTheme.secondaryColor,
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        StreamBuilder<List<TasksRecord>>(
                          stream: queryTasksRecord(
                            queryBuilder: (tasksRecord) => tasksRecord
                                .where('user', isEqualTo: currentUserReference)
                                .where('level_id',
                                    isEqualTo:
                                        getJsonField(widget.level, r'''$.id''')
                                            .toString()),
                            singleRecord: true,
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: LinearProgressIndicator(
                                  color: FlutterFlowTheme.primaryColor,
                                ),
                              );
                            }
                            List<TasksRecord> containerTasksRecordList =
                                snapshot.data;
                            // Customize what your widget looks like with no query results.
                            if (snapshot.data.isEmpty) {
                              return Material(
                                child: Container(
                                  height: 100,
                                  child: Center(
                                    child: Text('No results.'),
                                  ),
                                ),
                              );
                            }
                            final containerTasksRecord =
                                containerTasksRecordList.first;
                            return Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 1,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.secondaryColor,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 20, 15, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getJsonField(widget.level,
                                              r'''$.fields.Name''')
                                          .toString(),
                                      style: FlutterFlowTheme.title1.override(
                                        fontFamily: 'Playfair Display',
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 20),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 6, 0),
                                            child: Text(
                                              getJsonField(widget.level,
                                                      r'''$.fields.Description''')
                                                  .toString(),
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Playfair Display',
                                                color: FlutterFlowTheme
                                                    .tertiaryColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 16),
                                      child: FlutterFlowVideoPlayer(
                                        path:
                                            'https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4',
                                        videoType: VideoType.network,
                                        autoPlay: false,
                                        looping: true,
                                        showControls: true,
                                        allowFullScreen: true,
                                        allowPlaybackSpeedMenu: false,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
                                      child: Text(
                                        'Progress',
                                        style: FlutterFlowTheme.title1.override(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 6),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'You\'ve practiced',
                                            style: FlutterFlowTheme.subtitle2
                                                .override(
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    6, 0, 0, 0),
                                            child: Text(
                                              'X',
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Playfair Display',
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    6, 0, 0, 0),
                                            child: Text(
                                              '/',
                                              style: FlutterFlowTheme.bodyText1
                                                  .override(
                                                fontFamily: 'Playfair Display',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    6, 0, 0, 0),
                                            child: Text(
                                              'Y',
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Playfair Display',
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    6, 0, 0, 0),
                                            child: Text(
                                              'times, keep it up!',
                                              style: FlutterFlowTheme.subtitle2
                                                  .override(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 6, 0, 16),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Track each time you practice  by tapping \nthe plus button',
                                            style: FlutterFlowTheme.subtitle2
                                                .override(
                                              fontFamily: 'Poppins',
                                              color: FlutterFlowTheme
                                                  .tertiaryColor,
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              final practiceIterationsUpdateData =
                                                  {
                                                'num_iterations':
                                                    FieldValue.increment(1),
                                              };
                                              await levelPagePracticeIterationsRecord
                                                  .reference
                                                  .update(
                                                      practiceIterationsUpdateData);
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text('Nice work!'),
                                                    content:
                                                        Text('Keep it up.'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext),
                                                        child: Text('Ok'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              Icons.add_box_outlined,
                                              color:
                                                  FlutterFlowTheme.primaryColor,
                                              size: 30,
                                            ),
                                            iconSize: 30,
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
                                      child: Text(
                                        dateTimeFormat(
                                            'MEd', widget.task.dueDate),
                                        style: FlutterFlowTheme.title1.override(
                                          fontFamily: 'Playfair Display',
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      dateTimeFormat(
                                          'relative', widget.task.createdDate),
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Playfair Display',
                                      ),
                                    ),
                                    Text(
                                      widget.task.status,
                                      style:
                                          FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Playfair Display',
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 84,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.secondaryColor,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        final tasksUpdateData = createTasksRecordData(
                          status: 'completed',
                        );
                        await widget.task.reference.update(tasksUpdateData);
                        await Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 300),
                            reverseDuration: Duration(milliseconds: 300),
                            child: NavBarPage(initialPage: 'TaskListPage'),
                          ),
                          (r) => false,
                        );
                      },
                      text: 'Mark Completed',
                      icon: Icon(
                        Icons.check_box_outlined,
                        color: Colors.white,
                        size: 15,
                      ),
                      options: FFButtonOptions(
                        width: 200,
                        height: 50,
                        color: FlutterFlowTheme.primaryColor,
                        textStyle: FlutterFlowTheme.subtitle1.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 6,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
