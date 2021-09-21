import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_video_player.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../level_page/level_page_widget.dart';
import '../main.dart';
import '../schedule_task_page/schedule_task_page_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LearningItemPageWidget extends StatefulWidget {
  LearningItemPageWidget({
    Key key,
    this.learningItem,
  }) : super(key: key);

  final dynamic learningItem;

  @override
  _LearningItemPageWidgetState createState() => _LearningItemPageWidgetState();
}

class _LearningItemPageWidgetState extends State<LearningItemPageWidget> {
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
        final learningItemPageUsersRecord = snapshot.data;
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
              getJsonField(widget.learningItem, r'''$.fields.Name''')
                  .toString(),
              style: FlutterFlowTheme.bodyText2.override(
                fontFamily: 'Playfair Display',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              ToggleIcon(
                onPressed: () async {
                  final savedItemsElement =
                      getJsonField(widget.learningItem, r'''$.id''').toString();
                  final savedItemsUpdate = learningItemPageUsersRecord
                          .savedItems
                          .contains(savedItemsElement)
                      ? FieldValue.arrayRemove([savedItemsElement])
                      : FieldValue.arrayUnion([savedItemsElement]);
                  final usersUpdateData = {
                    'saved_items': savedItemsUpdate,
                  };
                  await learningItemPageUsersRecord.reference
                      .update(usersUpdateData);
                },
                value: learningItemPageUsersRecord.savedItems.contains(
                    /* NOT RECOMMENDED */ getJsonField(
                                widget.learningItem, r'''$.id''')
                            .toString() ==
                        'true'),
                onIcon: Icon(
                  Icons.star_outlined,
                  color: Colors.black,
                  size: 25,
                ),
                offIcon: Icon(
                  Icons.star_outline,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 1.2,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.secondaryColor,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getJsonField(widget.learningItem,
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
                                      0, 10, 0, 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 6, 0),
                                        child: Text(
                                          getJsonField(widget.learningItem,
                                                  r'''$.fields.Description''')
                                              .toString(),
                                          style: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Playfair Display',
                                            color:
                                                FlutterFlowTheme.tertiaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
                                      child: Text(
                                        'More info',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Playfair Display',
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      height: 30,
                                      thickness: 0.5,
                                      color: FlutterFlowTheme.tertiaryColor,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 10),
                                      child: Text(
                                        'Let\'s Practice!',
                                        style: FlutterFlowTheme.title1.override(
                                          fontFamily: 'Playfair Display',
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Add an activity to your task list by clicking the plus button next to the item you want to practice.',
                                      style:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.tertiaryColor,
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 0),
                                      child: Builder(
                                        builder: (context) {
                                          final levelIds = getJsonField(
                                                      widget.learningItem,
                                                      r'''$.fields.Levels''')
                                                  ?.toList() ??
                                              [];
                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: levelIds.length,
                                            itemBuilder:
                                                (context, levelIdsIndex) {
                                              final levelIdsItem =
                                                  levelIds[levelIdsIndex];
                                              return Container(
                                                width: 300,
                                                height: 90,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme
                                                      .secondaryColor,
                                                ),
                                                child: FutureBuilder<dynamic>(
                                                  future: getLevelCall(
                                                    levelID: getJsonField(
                                                            levelIdsItem,
                                                            r'''$.''')
                                                        .toString(),
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child:
                                                            LinearProgressIndicator(
                                                          color:
                                                              FlutterFlowTheme
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
                                                      child: StreamBuilder<
                                                          List<
                                                              PracticeIterationsRecord>>(
                                                        stream:
                                                            queryPracticeIterationsRecord(
                                                          queryBuilder: (practiceIterationsRecord) => practiceIterationsRecord
                                                              .where('user',
                                                                  isEqualTo:
                                                                      currentUserReference)
                                                              .where('level_id',
                                                                  isEqualTo: getJsonField(
                                                                          levelIdsItem,
                                                                          r'''$.''')
                                                                      .toString()),
                                                          singleRecord: true,
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child:
                                                                  LinearProgressIndicator(
                                                                color: FlutterFlowTheme
                                                                    .primaryColor,
                                                              ),
                                                            );
                                                          }
                                                          List<PracticeIterationsRecord>
                                                              rowPracticeIterationsRecordList =
                                                              snapshot.data;
                                                          // Customize what your widget looks like with no query results.
                                                          if (snapshot
                                                              .data.isEmpty) {
                                                            return Material(
                                                              child: Container(
                                                                height: 100,
                                                                child: Center(
                                                                  child: Text(
                                                                      'No results.'),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          final rowPracticeIterationsRecord =
                                                              rowPracticeIterationsRecordList
                                                                  .first;
                                                          return Row(
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
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
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
                                                                          alignment: AlignmentDirectional(
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                16,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Text(
                                                                              getJsonField(cardGetLevelResponse, r'''$.fields.Name''').toString(),
                                                                              style: FlutterFlowTheme.bodyText2.override(
                                                                                fontFamily: 'Playfair Display',
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
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
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              16,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            rowPracticeIterationsRecord.numIterations.toString(),
                                                                            style:
                                                                                FlutterFlowTheme.bodyText1.override(
                                                                              fontFamily: 'Playfair Display',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              10,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            '/',
                                                                            style:
                                                                                FlutterFlowTheme.bodyText1.override(
                                                                              fontFamily: 'Playfair Display',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              10,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            getJsonField(cardGetLevelResponse, r'''$.fields.Repetitions''').toString(),
                                                                            style:
                                                                                FlutterFlowTheme.bodyText1.override(
                                                                              fontFamily: 'Playfair Display',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              10,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          child:
                                                                              Text(
                                                                            'done!',
                                                                            style:
                                                                                FlutterFlowTheme.bodyText1.override(
                                                                              fontFamily: 'Playfair Display',
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
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              16,
                                                                              0),
                                                                      child:
                                                                          IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => ScheduleTaskPageWidget(
                                                                                level: cardGetLevelResponse,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .add_box,
                                                                          color:
                                                                              FlutterFlowTheme.primaryColor,
                                                                          size:
                                                                              30,
                                                                        ),
                                                                        iconSize:
                                                                            30,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            16,
                                                                            0),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        await Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                LevelPageWidget(
                                                                              level: cardGetLevelResponse,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_forward_ios,
                                                                        color: FlutterFlowTheme
                                                                            .tertiaryColor,
                                                                        size:
                                                                            24,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 30, 0, 20),
                                    child: InkWell(
                                      onTap: () async {
                                        await launchURL(
                                            'http://baxterandbella.com');
                                      },
                                      child: Text(
                                        'View on Baxter & Bella Website',
                                        style:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Playfair Display',
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
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
                        final usersUpdateData = {
                          'saved_items': FieldValue.arrayUnion([
                            getJsonField(widget.learningItem, r'''$.id''')
                                .toString()
                          ]),
                        };
                        await currentUserReference.update(usersUpdateData);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NavBarPage(initialPage: 'SavedItems'),
                          ),
                        );
                      },
                      text: 'Save Item',
                      icon: Icon(
                        Icons.star_outline,
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
