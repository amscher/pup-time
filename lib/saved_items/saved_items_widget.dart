import '../auth/auth_util.dart';
import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../learning_item_page/learning_item_page_widget.dart';
import '../login_page/login_page_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedItemsWidget extends StatefulWidget {
  SavedItemsWidget({Key key}) : super(key: key);

  @override
  _SavedItemsWidgetState createState() => _SavedItemsWidgetState();
}

class _SavedItemsWidgetState extends State<SavedItemsWidget> {
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
        final savedItemsUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            title: Text(
              'My List',
              style: FlutterFlowTheme.bodyText2.override(
                fontFamily: 'Playfair Display',
                fontSize: 34,
                fontWeight: FontWeight.bold,
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final savedItems =
                          savedItemsUsersRecord.savedItems?.toList() ?? [];
                      if (savedItems.isEmpty) {
                        return Center(
                          child: Image.asset(
                            'assets/images/emptyCollection.png',
                            width: MediaQuery.of(context).size.width * 0.86,
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: savedItems.length,
                        itemBuilder: (context, savedItemsIndex) {
                          final savedItemsItem = savedItems[savedItemsIndex];
                          return FutureBuilder<dynamic>(
                            future: getLearningItemCall(
                              itemID: savedItemsItem,
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
                              final cardGetLearningItemResponse = snapshot.data;
                              return InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LearningItemPageWidget(
                                        learningItem:
                                            cardGetLearningItemResponse,
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 0, 0, 0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    getJsonField(
                                                            cardGetLearningItemResponse,
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
                                                                  .fromSTEB(0,
                                                                      0, 6, 0),
                                                          child: Text(
                                                            getJsonField(
                                                                    cardGetLearningItemResponse,
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
                                                                    cardGetLearningItemResponse,
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
                                                            cardGetLearningItemResponse,
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
                                        IconButton(
                                          onPressed: () async {
                                            final usersUpdateData = {
                                              'saved_items':
                                                  FieldValue.arrayRemove(
                                                      [savedItemsItem]),
                                            };
                                            await currentUserReference
                                                .update(usersUpdateData);
                                          },
                                          icon: Icon(
                                            Icons.star_rate,
                                            color: Color(0xFF2555BB),
                                            size: 30,
                                          ),
                                          iconSize: 30,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: FlutterFlowTheme.tertiaryColor,
                                          size: 24,
                                        )
                                      ],
                                    ),
                                  ),
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
        );
      },
    );
  }
}
