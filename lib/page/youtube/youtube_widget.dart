import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:sticky_headers/sticky_headers.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'youtube_model.dart';
export 'youtube_model.dart';

class YoutubeWidget extends StatefulWidget {
  const YoutubeWidget({super.key});

  @override
  State<YoutubeWidget> createState() => _YoutubeWidgetState();
}

class _YoutubeWidgetState extends State<YoutubeWidget> {
  late YoutubeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => YoutubeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().isLoading = true;
      safeSetState(() {});
      _model.newList = await actions.fetchChannelsListFromHiveAsJson();
      FFAppState().channelsList = _model.newList!.toList().cast<dynamic>();
      safeSetState(() {});
      if (FFAppState().channelsList.isNotEmpty) {
        FFAppState().ChannelId = getJsonField(
          FFAppState().channelsList.firstOrNull,
          r'''$.channelId''',
        ).toString().toString();
        safeSetState(() {});
        await actions.loadChannelData(
          FFAppState().ChannelId,
        );
      } else {
        FFAppState().ChannelId = '';
        FFAppState().lastUsedChannelId = '';
        FFAppState().selectedItem = null;
        FFAppState().videoListJson = '';
        FFAppState().test = [];
        FFAppState().selectedIconUrl = null;
        FFAppState().selectedVideoId = '';
        FFAppState().HTMLForWebView = '';
        safeSetState(() {});
      }

      FFAppState().isLoading = false;
      FFAppState().showBookmarkMode = false;
      safeSetState(() {});
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: FFAppState().youtubequery(
        requestFn: () => YoutubeDataAPICall.call(),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final youtubeYoutubeDataAPIResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                controller: _model.columnController,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    StickyHeader(
                      overlapHeaders: false,
                      header: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4.0,
                                color: Color(0x33000000),
                                offset: Offset(
                                  0.0,
                                  2.0,
                                ),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: SizedBox(
                                        width: 180.0,
                                        child: TextFormField(
                                          controller: _model.textController,
                                          focusNode: _model.textFieldFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.textController',
                                            const Duration(milliseconds: 2000),
                                            () => safeSetState(() {}),
                                          ),
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                    ),
                                            hintText:
                                                '動画URL(全範囲) / キーワード(Channel内)',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0x00000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            suffixIcon: _model.textController!
                                                    .text.isNotEmpty
                                                ? InkWell(
                                                    onTap: () async {
                                                      _model.textController
                                                          ?.clear();
                                                      safeSetState(() {});
                                                    },
                                                    child: const Icon(
                                                      Icons.clear,
                                                      size: 22,
                                                    ),
                                                  )
                                                : null,
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                letterSpacing: 0.0,
                                              ),
                                          cursorColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          validator: _model
                                              .textControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 8.0,
                                      buttonSize: 40.0,
                                      icon: Icon(
                                        Icons.search_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 26.0,
                                      ),
                                      onPressed: () async {
                                        _model.searchResult =
                                            await actions.performLocalSearch(
                                          _model.textController.text,
                                        );

                                        safeSetState(() {});
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 5.0, 0.0),
                                    child: ToggleIcon(
                                      onPressed: () async {
                                        safeSetState(() =>
                                            FFAppState().showBookmarkMode =
                                                !FFAppState().showBookmarkMode);
                                        if (FFAppState().showBookmarkMode ==
                                            true) {
                                          _model.allBookmarksIcon =
                                              await actions.fetchAllBookmarks();
                                          FFAppState().myBookmarksJsonList =
                                              _model.allBookmarksIcon!
                                                  .toList()
                                                  .cast<dynamic>();
                                          safeSetState(() {});
                                          if (FFAppState()
                                                  .myBookmarksJsonList.isNotEmpty) {
                                            FFAppState().selectedVideoId =
                                                getJsonField(
                                              FFAppState()
                                                  .myBookmarksJsonList
                                                  .firstOrNull,
                                              r'''$.snippet.resourceId.videoId''',
                                            ).toString();
                                            safeSetState(() {});
                                            FFAppState().HTMLForWebView =
                                                '<html> <head>   <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">   <style>     .video-container {       position: relative;       width: 100%;       padding-top: 65%;       overflow: hidden;     }     .video-container iframe {       position: absolute;       top: 0; left: 0;       width: 100%; height: 100%;       border: 0;     }   </style> </head> <body style=\"margin:0;padding:0;overflow:hidden;\">   <div class=\"video-container\">     <iframe       src=\"https://www.youtube.com/embed/${FFAppState().selectedVideoId}?autoplay=0\"       allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\"       allowfullscreen>     </iframe>   </div> </body> </html>';
                                            safeSetState(() {});
                                            FFAppState().selectedItem =
                                                FFAppState()
                                                    .myBookmarksJsonList
                                                    .firstOrNull!;
                                            safeSetState(() {});
                                            _model.foundIconUrl = await actions
                                                .findIconUrlByChannelId(
                                              getJsonField(
                                                FFAppState().selectedItem,
                                                r'''$.snippet.channelId''',
                                              ).toString(),
                                            );
                                            FFAppState().selectedIconUrl =
                                                _model.foundIconUrl!;
                                            safeSetState(() {});
                                          } else {
                                            FFAppState().selectedVideoId = '';
                                            FFAppState().selectedItem = null;
                                            FFAppState().selectedIconUrl = null;
                                            FFAppState().HTMLForWebView = '';
                                            safeSetState(() {});
                                          }
                                        } else {
                                          await actions.loadChannelData(
                                            getJsonField(
                                              FFAppState()
                                                  .channelsList
                                                  .firstOrNull,
                                              r'''$.channelId''',
                                            ).toString(),
                                          );
                                        }

                                        safeSetState(() {
                                          _model.textController?.clear();
                                        });

                                        safeSetState(() {});
                                      },
                                      value: FFAppState().showBookmarkMode,
                                      onIcon: Icon(
                                        Icons.bookmark_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 26.0,
                                      ),
                                      offIcon: Icon(
                                        Icons.bookmark_border_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 72.0,
                                decoration: const BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Builder(
                                        builder: (context) {
                                          final channelsIcon = FFAppState()
                                              .channelsList
                                              .toList();

                                          return ListView.separated(
                                            padding: const EdgeInsets.fromLTRB(
                                              20.0,
                                              0,
                                              0,
                                              0,
                                            ),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: channelsIcon.length,
                                            separatorBuilder: (_, __) =>
                                                const SizedBox(width: 10.0),
                                            itemBuilder:
                                                (context, channelsIconIndex) {
                                              final channelsIconItem =
                                                  channelsIcon[
                                                      channelsIconIndex];
                                              return Align(
                                                alignment: const AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 0.0),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      if (FFAppState()
                                                              .showBookmarkMode ==
                                                          true) {
                                                        FFAppState()
                                                                .showBookmarkMode =
                                                            false;
                                                        safeSetState(() {});
                                                        FFAppState().ChannelId =
                                                            getJsonField(
                                                          channelsIconItem,
                                                          r'''$.channelId''',
                                                        ).toString();
                                                        safeSetState(() {});
                                                        await actions
                                                            .loadChannelData(
                                                          FFAppState()
                                                              .ChannelId,
                                                        );
                                                      } else {
                                                        _model.tappedChannelId =
                                                            actions
                                                                .safeToStringValue(
                                                          getJsonField(
                                                            channelsIconItem,
                                                            r'''$.channelId''',
                                                          ),
                                                        );
                                                        FFAppState().ChannelId =
                                                            getJsonField(
                                                          channelsIconItem,
                                                          r'''$.channelId''',
                                                        ).toString();
                                                        safeSetState(() {});
                                                        await actions
                                                            .loadChannelData(
                                                          FFAppState()
                                                              .ChannelId,
                                                        );
                                                      }

                                                      safeSetState(() {
                                                        _model.textController
                                                            ?.clear();
                                                      });

                                                      safeSetState(() {});
                                                    },
                                                    child: Container(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.network(
                                                        getJsonField(
                                                          channelsIconItem,
                                                          r'''$.iconUrl''',
                                                        ).toString(),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            controller:
                                                _model.listViewController1,
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 10.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          context.pushNamed('Setting');
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 30.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      content: Visibility(
                        visible: FFAppState().isLoading == false,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FlutterFlowWebView(
                                  content: FFAppState().HTMLForWebView,
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).width * 0.65,
                                  verticalScroll: false,
                                  horizontalScroll: false,
                                  html: true,
                                ),
                                if (!((FFAppState()
                                                .showBookmarkMode
                                                .toString() ==
                                            true &&
                                        FFAppState()
                                            .myBookmarksJsonList
                                            .map((e) => e.toString())
                                            .toList()
                                            .isEmpty) ||
                                    (FFAppState().showBookmarkMode.toString() ==
                                            false &&
                                        FFAppState()
                                            .test
                                            .map((e) => e.toString())
                                            .toList()
                                            .isEmpty)))
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        8.0, 5.0, 8.0, 0.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if ((getJsonField(
                                                        FFAppState()
                                                            .selectedItem,
                                                        r'''$.snippet.title''',
                                                      ) !=
                                                      null) &&
                                                  (getJsonField(
                                                        FFAppState()
                                                            .selectedIconUrl,
                                                        r'''$.iconUrl''',
                                                      ) !=
                                                      null))
                                                Container(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.network(
                                                    getJsonField(
                                                      FFAppState()
                                                          .selectedIconUrl,
                                                      r'''$.iconUrl''',
                                                    ).toString(),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              if (FFAppState().selectedItem !=
                                                  null)
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      getJsonField(
                                                        FFAppState()
                                                            .selectedItem,
                                                        r'''$.snippet.title''',
                                                      ).toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 3,
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        55.0, 0.0, 0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (FFAppState()
                                                            .selectedItem !=
                                                        null)
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      15.0,
                                                                      0.0),
                                                          child: Text(
                                                            getJsonField(
                                                              FFAppState()
                                                                  .selectedItem,
                                                              r'''$.snippet.channelTitle''',
                                                            ).toString(),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        if (FFAppState()
                                                                .selectedItem !=
                                                            null)
                                                          Text(
                                                            valueOrDefault<
                                                                String>(
                                                              functions.formatIsoToSlashDate(
                                                                  valueOrDefault<
                                                                      String>(
                                                                getJsonField(
                                                                  FFAppState()
                                                                      .selectedItem,
                                                                  r'''$.snippet.publishedAt''',
                                                                )?.toString(),
                                                                '0',
                                                              )),
                                                              'yy/mm/dd',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        if (FFAppState()
                                                                    .selectedVideoId !=
                                                                '')
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                'YouTube利用規約',
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Inter',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      fontSize:
                                                                          10.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (getJsonField(
                                                    FFAppState().selectedItem,
                                                    r'''$.snippet.title''',
                                                  ) !=
                                                  null)
                                                ToggleIcon(
                                                  onPressed: () async {
                                                    safeSetState(
                                                      () => FFAppState()
                                                              .bookmarkedVideoIds
                                                              .contains(FFAppState()
                                                                  .selectedVideoId)
                                                          ? FFAppState()
                                                              .removeFromBookmarkedVideoIds(
                                                                  FFAppState()
                                                                      .selectedVideoId)
                                                          : FFAppState()
                                                              .addToBookmarkedVideoIds(
                                                                  FFAppState()
                                                                      .selectedVideoId),
                                                    );
                                                    if (!FFAppState()
                                                        .bookmarkedVideoIds
                                                        .contains(FFAppState()
                                                            .selectedVideoId)) {
                                                      await actions
                                                          .removeBookmark(
                                                        FFAppState()
                                                            .selectedVideoId,
                                                      );
                                                    } else {
                                                      await actions
                                                          .createBookmark(
                                                        FFAppState()
                                                            .selectedItem,
                                                      );
                                                    }
                                                  },
                                                  value: FFAppState()
                                                      .bookmarkedVideoIds
                                                      .contains(FFAppState()
                                                          .selectedVideoId),
                                                  onIcon: Icon(
                                                    Icons.bookmark,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                  offIcon: Icon(
                                                    Icons.bookmark_border,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24.0,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          Divider(
                                            thickness: 1.0,
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Builder(
                              builder: (context) {
                                final items = (FFAppState().showBookmarkMode
                                        ? FFAppState().myBookmarksJsonList
                                        : FFAppState().test)
                                    .toList()
                                    .take(100)
                                    .toList();

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  primary: false,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: items.length,
                                  itemBuilder: (context, itemsIndex) {
                                    final itemsItem = items[itemsIndex];
                                    return Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          8.0, 0.0, 8.0, 10.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          FFAppState().selectedVideoId =
                                              getJsonField(
                                            itemsItem,
                                            r'''$.snippet.resourceId.videoId''',
                                          ).toString();
                                          safeSetState(() {});
                                          FFAppState().selectedItem = itemsItem;
                                          safeSetState(() {});
                                          FFAppState().HTMLForWebView =
                                              '<html> <head>   <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">   <style>     .video-container {       position: relative;       width: 100%;       padding-top: 65%;       overflow: hidden;     }     .video-container iframe {       position: absolute;       top: 0; left: 0;       width: 100%; height: 100%;       border: 0;     }   </style> </head> <body style=\"margin:0;padding:0;overflow:hidden;\">   <div class=\"video-container\">     <iframe       src=\"https://www.youtube.com/embed/${FFAppState().selectedVideoId}?autoplay=0\"       allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\"       allowfullscreen>     </iframe>   </div> </body> </html>';
                                          safeSetState(() {});
                                          await _model.columnController
                                              ?.animateTo(
                                            0,
                                            duration:
                                                const Duration(milliseconds: 100),
                                            curve: Curves.ease,
                                          );
                                        },
                                        child: SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          child: Stack(
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
                                            children: [
                                              Align(
                                                alignment: const AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  height: 80.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          child: Image.network(
                                                            getJsonField(
                                                              itemsItem,
                                                              r'''$.snippet.thumbnails.default.url''',
                                                            ).toString(),
                                                            height: 80.0,
                                                            fit: BoxFit.cover,
                                                            errorBuilder: (context,
                                                                    error,
                                                                    stackTrace) =>
                                                                Image.asset(
                                                              'assets/images/error_image.png',
                                                              height: 80.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      6.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                child: Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            2.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      getJsonField(
                                                                        itemsItem,
                                                                        r'''$.snippet.title''',
                                                                      ).toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      maxLines:
                                                                          3,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            getJsonField(
                                                                              itemsItem,
                                                                              r'''$.snippet.channelTitle''',
                                                                            ).toString(),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Inter',
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  fontSize: 11.0,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              functions.formatIsoToSlashDate(getJsonField(
                                                                                itemsItem,
                                                                                r'''$.snippet.publishedAt''',
                                                                              ).toString()),
                                                                              '0',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Inter',
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  fontSize: 11.0,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    ToggleIcon(
                                                                      onPressed:
                                                                          () async {
                                                                        safeSetState(
                                                                          () => FFAppState().bookmarkedVideoIds.contains(getJsonField(
                                                                                    itemsItem,
                                                                                    r'''$.snippet.resourceId.videoId''',
                                                                                  ).toString())
                                                                              ? FFAppState().removeFromBookmarkedVideoIds(getJsonField(
                                                                                  itemsItem,
                                                                                  r'''$.snippet.resourceId.videoId''',
                                                                                ).toString())
                                                                              : FFAppState().addToBookmarkedVideoIds(getJsonField(
                                                                                  itemsItem,
                                                                                  r'''$.snippet.resourceId.videoId''',
                                                                                ).toString()),
                                                                        );
                                                                        if (!FFAppState()
                                                                            .bookmarkedVideoIds
                                                                            .contains(getJsonField(
                                                                              itemsItem,
                                                                              r'''$.snippet.resourceId.videoId''',
                                                                            ).toString())) {
                                                                          await actions
                                                                              .removeBookmark(
                                                                            getJsonField(
                                                                              itemsItem,
                                                                              r'''$.snippet.resourceId.videoId''',
                                                                            ).toString(),
                                                                          );
                                                                        } else {
                                                                          await actions
                                                                              .createBookmark(
                                                                            itemsItem,
                                                                          );
                                                                        }
                                                                      },
                                                                      value: FFAppState()
                                                                          .bookmarkedVideoIds
                                                                          .contains(
                                                                              getJsonField(
                                                                            itemsItem,
                                                                            r'''$.snippet.resourceId.videoId''',
                                                                          ).toString()),
                                                                      onIcon:
                                                                          Icon(
                                                                        Icons
                                                                            .bookmark,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        size:
                                                                            24.0,
                                                                      ),
                                                                      offIcon:
                                                                          Icon(
                                                                        Icons
                                                                            .bookmark_border,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        size:
                                                                            24.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  controller: _model.listViewController2,
                                );
                              },
                            ),
                            if (FFAppState().nextPageToken != '')
                              Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    await actions.loadMoreVideosForChannel(
                                      FFAppState().ChannelId,
                                    );
                                  },
                                  text: 'もっと見る',
                                  options: FFButtonOptions(
                                    height: 30.0,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (FFAppState().isLoading == true)
                      Align(
                        alignment: const AlignmentDirectional(0.0, 1.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 100.0, 0.0, 0.0),
                          child: Lottie.asset(
                            'assets/jsons/Animation_-_1736325050881.json',
                            width: 50.0,
                            height: 50.0,
                            fit: BoxFit.contain,
                            animate: true,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
