import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../learning_item_page/learning_item_page_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainingStagePageWidget extends StatefulWidget {
  TrainingStagePageWidget({
    Key key,
    this.stageNameUrlEncoded,
    this.stageName,
  }) : super(key: key);

  final String stageNameUrlEncoded;
  final String stageName;

  @override
  _TrainingStagePageWidgetState createState() =>
      _TrainingStagePageWidgetState();
}

class _TrainingStagePageWidgetState extends State<TrainingStagePageWidget> {
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
        final trainingStagePageUsersRecord = snapshot.data;
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
              widget.stageName,
              style: FlutterFlowTheme.bodyText2.override(
                fontFamily: 'Playfair Display',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [],
            centerTitle: true,
            elevation: 0,
          ),
          backgroundColor: FlutterFlowTheme.secondaryColor,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              FutureBuilder<dynamic>(
                future: getItemsForStageCall(
                  view: widget.stageNameUrlEncoded,
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
                  final listViewGetItemsForStageResponse = snapshot.data;
                  return Builder(
                    builder: (context) {
                      final learningItems = getJsonField(
                                  listViewGetItemsForStageResponse,
                                  r'''$.records''')
                              ?.toList() ??
                          [];
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: learningItems.length,
                        itemBuilder: (context, learningItemsIndex) {
                          final learningItemsItem =
                              learningItems[learningItemsIndex];
                          return Container(
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LearningItemPageWidget(
                                      learningItem: learningItemsItem,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LearningItemPageWidget(
                                          learningItem: learningItemsItem,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.network(
                                              'https://picsum.photos/seed/231/600',
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 0, 0, 0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      getJsonField(
                                                              learningItemsItem,
                                                              r'''$.fields.Name''')
                                                          .toString(),
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                        fontFamily:
                                                            'Playfair Display',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 3, 0, 6),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        6,
                                                                        0),
                                                            child: Text(
                                                              getJsonField(
                                                                      learningItemsItem,
                                                                      r'''$.fields.Description''')
                                                                  .toString(),
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                fontFamily:
                                                                    'Playfair Display',
                                                                color: FlutterFlowTheme
                                                                    .tertiaryColor,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: AutoSizeText(
                                                              getJsonField(
                                                                      learningItemsItem,
                                                                      r'''$.fields.Difficulty''')
                                                                  .toString(),
                                                              style:
                                                                  FlutterFlowTheme
                                                                      .bodyText2
                                                                      .override(
                                                                fontFamily:
                                                                    'Playfair Display',
                                                                color: FlutterFlowTheme
                                                                    .tertiaryColor,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      getJsonField(
                                                              learningItemsItem,
                                                              r'''$.fields.CategoryName[0]''')
                                                          .toString(),
                                                      style: FlutterFlowTheme
                                                          .bodyText2
                                                          .override(
                                                        fontFamily:
                                                            'Playfair Display',
                                                        color: FlutterFlowTheme
                                                            .primaryColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                FlutterFlowTheme.tertiaryColor,
                                            size: 24,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
