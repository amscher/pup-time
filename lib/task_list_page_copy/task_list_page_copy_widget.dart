import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../complete_task_page/complete_task_page_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../level_page/level_page_widget.dart';
import '../login_page/login_page_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskListPageCopyWidget extends StatefulWidget {
  TaskListPageCopyWidget({Key key}) : super(key: key);

  @override
  _TaskListPageCopyWidgetState createState() => _TaskListPageCopyWidgetState();
}

class _TaskListPageCopyWidgetState extends State<TaskListPageCopyWidget> {
  dynamic past_due_level;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(currentUserReference),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: LinearProgressIndicator(
              color: FlutterFlowTheme.primaryColor,
            ),
          );
        }
        final taskListPageCopyUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            title: Text(
              'Today\'s Focus List',
              style: FlutterFlowTheme.title3.override(
                fontFamily: 'Poppins',
              ),
            ),
            actions: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 3, 14, 0),
                  child: InkWell(
                    onTap: () async {
                      await signOut();
                      await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPageWidget(),
                        ),
                        (r) => false,
                      );
                    },
                    child: Text(
                      'Logout',
                      style: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              )
            ],
            centerTitle: true,
            elevation: 0,
          ),
          backgroundColor: FlutterFlowTheme.secondaryColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.secondaryColor,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
                              child: Text(
                                'These are your focus items for today!\nWhen you\'re ready to practice, select the item and mark which actions you complete today.',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.subtitle2.override(
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 75, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-0.85, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                child: Text(
                                  'Past Due Tasks',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.subtitle1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            StreamBuilder<List<TasksRecord>>(
                              stream: queryTasksRecord(
                                queryBuilder: (tasksRecord) => tasksRecord
                                    .where('user',
                                        isEqualTo: currentUserReference)
                                    .where('due_date',
                                        isLessThan: getCurrentTimestamp)
                                    .where('status', isEqualTo: 'incomplete')
                                    .orderBy('due_date'),
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
                                List<TasksRecord> listViewTasksRecordList =
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
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: listViewTasksRecordList.length,
                                  itemBuilder: (context, listViewIndex) {
                                    final listViewTasksRecord =
                                        listViewTasksRecordList[listViewIndex];
                                    return InkWell(
                                      onTap: () async {
                                        past_due_level = await getLevelCall(
                                          levelID: listViewTasksRecord.levelId,
                                        );
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LevelPageWidget(
                                              level: past_due_level,
                                            ),
                                          ),
                                        );

                                        setState(() {});
                                      },
                                      child: Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: Colors.white,
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          height: 160,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                          child: StreamBuilder<
                                              List<PracticeIterationsRecord>>(
                                            stream:
                                                queryPracticeIterationsRecord(
                                              queryBuilder:
                                                  (practiceIterationsRecord) =>
                                                      practiceIterationsRecord
                                                          .where('user',
                                                              isEqualTo:
                                                                  currentUserReference)
                                                          .where('level_id',
                                                              isEqualTo:
                                                                  listViewTasksRecord
                                                                      .levelId),
                                              singleRecord: true,
                                            ),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child:
                                                      LinearProgressIndicator(
                                                    color: FlutterFlowTheme
                                                        .primaryColor,
                                                  ),
                                                );
                                              }
                                              List<PracticeIterationsRecord>
                                                  stackPracticeIterationsRecordList =
                                                  snapshot.data;
                                              // Customize what your widget looks like with no query results.
                                              if (snapshot.data.isEmpty) {
                                                return Material(
                                                  child: Container(
                                                    height: 100,
                                                    child: Center(
                                                      child:
                                                          Text('No results.'),
                                                    ),
                                                  ),
                                                );
                                              }
                                              final stackPracticeIterationsRecord =
                                                  stackPracticeIterationsRecordList
                                                      .first;
                                              return Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 30, 0),
                                                    child:
                                                        FutureBuilder<dynamic>(
                                                      future: getLevelCall(
                                                        levelID:
                                                            listViewTasksRecord
                                                                .levelId,
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child:
                                                                LinearProgressIndicator(
                                                              color: FlutterFlowTheme
                                                                  .primaryColor,
                                                            ),
                                                          );
                                                        }
                                                        final columnGetLevelResponse =
                                                            snapshot.data;
                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          12,
                                                                          0,
                                                                          0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            6,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          getJsonField(columnGetLevelResponse, r'''$.fields.Name''')
                                                                              .toString(),
                                                                          style: FlutterFlowTheme
                                                                              .bodyText2
                                                                              .override(
                                                                            fontFamily:
                                                                                'Playfair Display',
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            16,
                                                                            0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                                                  child: Text(
                                                                                    'Difficulty: ',
                                                                                    style: FlutterFlowTheme.bodyText1.override(
                                                                                      fontFamily: 'Playfair Display',
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                                                  child: AutoSizeText(
                                                                                    getJsonField(columnGetLevelResponse, r'''$.fields.Difficulty''').toString(),
                                                                                    style: FlutterFlowTheme.bodyText2.override(
                                                                                      fontFamily: 'Playfair Display',
                                                                                      color: FlutterFlowTheme.tertiaryColor,
                                                                                      fontSize: 14,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            6,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      getJsonField(
                                                                              columnGetLevelResponse,
                                                                              r'''$.fields.Description''')
                                                                          .toString(),
                                                                      style: FlutterFlowTheme
                                                                          .bodyText2
                                                                          .override(
                                                                        fontFamily:
                                                                            'Playfair Display',
                                                                        color: FlutterFlowTheme
                                                                            .tertiaryColor,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            6,
                                                                            0,
                                                                            5),
                                                                        child:
                                                                            Text(
                                                                          'You\'ve practiced',
                                                                          style: FlutterFlowTheme
                                                                              .bodyText1
                                                                              .override(
                                                                            fontFamily:
                                                                                'Playfair Display',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            6,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          stackPracticeIterationsRecord
                                                                              .numIterations
                                                                              .toString(),
                                                                          style: FlutterFlowTheme
                                                                              .bodyText1
                                                                              .override(
                                                                            fontFamily:
                                                                                'Playfair Display',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            6,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          '/',
                                                                          style: FlutterFlowTheme
                                                                              .bodyText1
                                                                              .override(
                                                                            fontFamily:
                                                                                'Playfair Display',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        getJsonField(columnGetLevelResponse,
                                                                                r'''$.fields.Repetitions''')
                                                                            .toString(),
                                                                        style: FlutterFlowTheme
                                                                            .bodyText1
                                                                            .override(
                                                                          fontFamily:
                                                                              'Playfair Display',
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            6,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                        child:
                                                                            Text(
                                                                          'times so far!',
                                                                          style: FlutterFlowTheme
                                                                              .bodyText1
                                                                              .override(
                                                                            fontFamily:
                                                                                'Playfair Display',
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Divider(
                                                                    thickness:
                                                                        1,
                                                                    indent: 2,
                                                                    endIndent:
                                                                        16,
                                                                    color: Color(
                                                                        0xFF9E9E9E),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          0,
                                                                          16,
                                                                          0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          print(
                                                                              'IconButton pressed ...');
                                                                        },
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete_outline,
                                                                          color:
                                                                              FlutterFlowTheme.tertiaryColor,
                                                                          size:
                                                                              30,
                                                                        ),
                                                                        iconSize:
                                                                            30,
                                                                      ),
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          print(
                                                                              'IconButton pressed ...');
                                                                        },
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .edit_outlined,
                                                                          color:
                                                                              FlutterFlowTheme.tertiaryColor,
                                                                          size:
                                                                              30,
                                                                        ),
                                                                        iconSize:
                                                                            30,
                                                                      )
                                                                    ],
                                                                  ),
                                                                  IconButton(
                                                                    onPressed:
                                                                        () async {
                                                                      final practiceIterationsUpdateData =
                                                                          {
                                                                        'num_iterations':
                                                                            FieldValue.increment(1),
                                                                      };
                                                                      await stackPracticeIterationsRecord
                                                                          .reference
                                                                          .update(
                                                                              practiceIterationsUpdateData);

                                                                      final tasksUpdateData =
                                                                          createTasksRecordData(
                                                                        status:
                                                                            'complete',
                                                                      );
                                                                      await listViewTasksRecord
                                                                          .reference
                                                                          .update(
                                                                              tasksUpdateData);
                                                                      await Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              CompleteTaskPageWidget(
                                                                            levelCompleted:
                                                                                stackPracticeIterationsRecord,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .check_box_outlined,
                                                                      color: FlutterFlowTheme
                                                                          .primaryColor,
                                                                      size: 30,
                                                                    ),
                                                                    iconSize:
                                                                        30,
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.95, 0),
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: FlutterFlowTheme
                                                          .tertiaryColor,
                                                      size: 24,
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
