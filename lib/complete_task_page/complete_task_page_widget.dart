import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../level_page/level_page_widget.dart';
import '../main.dart';
import '../schedule_task_page/schedule_task_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteTaskPageWidget extends StatefulWidget {
  CompleteTaskPageWidget({
    Key key,
    this.levelCompleted,
  }) : super(key: key);

  final PracticeIterationsRecord levelCompleted;

  @override
  _CompleteTaskPageWidgetState createState() => _CompleteTaskPageWidgetState();
}

class _CompleteTaskPageWidgetState extends State<CompleteTaskPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.secondaryColor,
            ),
            child: Row(
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
          ),
          FutureBuilder<dynamic>(
            future: getLearningItemCall(
              itemID: widget.levelCompleted.itemId,
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
              final columnGetLearningItemResponse = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.secondaryColor,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                            child: Text(
                              'Nice Work!',
                              style: FlutterFlowTheme.title1.override(
                                fontFamily: 'Playfair Display',
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 0, 0),
                                  child: Text(
                                    widget.levelCompleted.numIterations
                                        .toString(),
                                    style: FlutterFlowTheme.title2.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.primaryColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      11, 0, 0, 0),
                                  child: Text(
                                    '/',
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Playfair Display',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Text(
                                    widget
                                        .levelCompleted.numIterationsRecommended
                                        .toString(),
                                    style: FlutterFlowTheme.title2.override(
                                      fontFamily: 'Poppins',
                                      color: FlutterFlowTheme.primaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 16, 0, 20),
                            child: Text(
                              'Practices Completed',
                              style: FlutterFlowTheme.subtitle1.override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.tertiaryColor,
                              ),
                            ),
                          ),
                          Divider(
                            indent: 50,
                            endIndent: 50,
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 500,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.secondaryColor,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'What do you want to practice next ?',
                              style: FlutterFlowTheme.subtitle1.override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.tertiaryColor,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: Builder(
                                builder: (context) {
                                  final levels = getJsonField(
                                              columnGetLearningItemResponse,
                                              r'''$.fields.Levels''')
                                          ?.toList() ??
                                      [];
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: levels.length,
                                    itemBuilder: (context, levelsIndex) {
                                      final levelsItem = levels[levelsIndex];
                                      return StreamBuilder<
                                          List<PracticeIterationsRecord>>(
                                        stream: queryPracticeIterationsRecord(
                                          queryBuilder:
                                              (practiceIterationsRecord) =>
                                                  practiceIterationsRecord
                                                      .where('user',
                                                          isEqualTo:
                                                              currentUserReference)
                                                      .where('level_id',
                                                          isEqualTo:
                                                              getJsonField(
                                                                      levelsItem,
                                                                      r'''$.''')
                                                                  .toString()),
                                          singleRecord: true,
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: LinearProgressIndicator(
                                                color: FlutterFlowTheme
                                                    .primaryColor,
                                              ),
                                            );
                                          }
                                          List<PracticeIterationsRecord>
                                              containerPracticeIterationsRecordList =
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
                                          final containerPracticeIterationsRecord =
                                              containerPracticeIterationsRecordList
                                                  .first;
                                          return Container(
                                            width: 100,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme
                                                  .secondaryColor,
                                            ),
                                            child: FutureBuilder<dynamic>(
                                              future: getLevelCall(
                                                levelID: getJsonField(
                                                        levelsItem, r'''$.''')
                                                    .toString(),
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
                                                final cardGetLevelResponse =
                                                    snapshot.data;
                                                return Card(
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  color: Color(0xFFF5F5F5),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        10,
                                                                        0,
                                                                        10),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0, 0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child: Text(
                                                                      getJsonField(
                                                                              cardGetLevelResponse,
                                                                              r'''$.fields.Name''')
                                                                          .toString(),
                                                                      style: FlutterFlowTheme
                                                                          .bodyText2
                                                                          .override(
                                                                        fontFamily:
                                                                            'Playfair Display',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        1,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    containerPracticeIterationsRecord
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
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    '/',
                                                                    style: FlutterFlowTheme
                                                                        .bodyText1
                                                                        .override(
                                                                      fontFamily:
                                                                          'Playfair Display',
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    getJsonField(
                                                                            cardGetLevelResponse,
                                                                            r'''$.fields.Repetitions''')
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
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    'Practices done!',
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
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0, 0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          16,
                                                                          0),
                                                              child: IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  await Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              ScheduleTaskPageWidget(
                                                                        level:
                                                                            cardGetLevelResponse,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                icon: Icon(
                                                                  Icons.add_box,
                                                                  color: FlutterFlowTheme
                                                                      .primaryColor,
                                                                  size: 30,
                                                                ),
                                                                iconSize: 30,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        16,
                                                                        0),
                                                            child: InkWell(
                                                              onTap: () async {
                                                                await Navigator
                                                                    .push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            LevelPageWidget(
                                                                      level:
                                                                          levelsItem,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                color: FlutterFlowTheme
                                                                    .tertiaryColor,
                                                                size: 24,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
