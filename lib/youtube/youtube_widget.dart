import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
      _model.cachedTimestamp = actions.getTimestampString();
      await actions.debugOnPageLoadStart();
      _model.currentTimestamp = actions.getCurrentTimestampString();
      _model.cacheValidResult = actions.isCacheValid(
        _model.cachedTimestamp,
        '86400000',
      );
      if (_model.cacheValidResult == 'true') {
        _model.cachedJson = actions.getVideoListJson();
        await actions.debugAfterGetVideoListJson(
          _model.cachedJson,
        );
        FFAppState().videoListJson = _model.cachedJson!;
        safeSetState(() {});
        _model.videoItemsListCached = await actions.extractItemsListFromJson(
          FFAppState().videoListJson,
        );
        await actions.debugAfterExtract();
        FFAppState().test =
            _model.videoItemsListCached!.toList().cast<dynamic>();
        safeSetState(() {});
        FFAppState().selectedItem = FFAppState().test.firstOrNull!;
        safeSetState(() {});
        _model.extractedVideoId = actions.extractVideoIdFromJson(
          _model.cachedJson,
        );
        FFAppState().selectedVideoId = _model.extractedVideoId!;
        safeSetState(() {});
        FFAppState().HTMLForWebView =
            '<html> <head>   <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">   <style>     .video-container {       position: relative;       width: 100%;       padding-top: 65%;       overflow: hidden;     }     .video-container iframe {       position: absolute;       top: 0; left: 0;       width: 100%; height: 100%;       border: 0;     }   </style> </head> <body style=\"margin:0;padding:0;overflow:hidden;\">   <div class=\"video-container\">     <iframe       src=\"https://www.youtube.com/embed/${FFAppState().selectedVideoId}?autoplay=0\"       allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\"       allowfullscreen>     </iframe>   </div> </body> </html>';
        safeSetState(() {});
        await actions.debugPrintVariables(
          '',
        );
      } else {
        _model.apiResultsvm = await YoutubeDataAPICall.call(
          channelIdParam: FFAppState().ChannelId,
        );

        if ((_model.apiResultsvm?.succeeded ?? true)) {
          _model.videoListJsonSafely = await actions.storeVideoListJsonSafely(
            (_model.apiResultsvm?.jsonBody ?? ''),
          );
          await actions.debugAfterSaveVideoListJson(
            _model.videoListJsonSafely,
          );
          actions.saveTimestamp(
            _model.currentTimestamp,
          );
          FFAppState().videoListJson = _model.videoListJsonSafely!;
          safeSetState(() {});
          _model.videoItemsListApi = await actions.extractItemsListFromJson(
            FFAppState().videoListJson,
          );
          FFAppState().test =
              _model.videoItemsListApi!.toList().cast<dynamic>();
          safeSetState(() {});
          _model.newVideoId = actions.extractVideoIdFromJson(
            FFAppState().videoListJson,
          );
          FFAppState().selectedVideoId = _model.newVideoId!;
          safeSetState(() {});
          await actions.debugPrintVariables(
            '',
          );
          FFAppState().selectedItem = FFAppState().test.firstOrNull!;
          safeSetState(() {});
          FFAppState().HTMLForWebView =
              '<html> <head>   <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">   <style>     .video-container {       position: relative;       width: 100%;       padding-top: 65%;       overflow: hidden;     }     .video-container iframe {       position: absolute;       top: 0; left: 0;       width: 100%; height: 100%;       border: 0;     }   </style> </head> <body style=\"margin:0;padding:0;overflow:hidden;\">   <div class=\"video-container\">     <iframe       src=\"https://www.youtube.com/embed/${FFAppState().selectedVideoId}?autoplay=0\"       allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\"       allowfullscreen>     </iframe>   </div> </body> </html>';
          safeSetState(() {});
        }
      }
    });
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
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                controller: _model.columnController,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 251.0,
                          height: 44.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: '検索',
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Inter Tight',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Icon(
                            Icons.add,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FlutterFlowWebView(
                          content: FFAppState().HTMLForWebView,
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).width * 0.65,
                          verticalScroll: false,
                          horizontalScroll: false,
                          html: true,
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 10.0),
                                  child: Text(
                                    getJsonField(
                                      FFAppState().selectedItem,
                                      r'''$.snippet.title''',
                                    ).toString(),
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Inter',
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-1.0, 0.0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 15.0, 0.0),
                                        child: Text(
                                          getJsonField(
                                            FFAppState().selectedItem,
                                            r'''$.snippet.channelTitle''',
                                          ).toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Inter',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      valueOrDefault<String>(
                                        functions.formatIsoToSlashDate(
                                            valueOrDefault<String>(
                                          getJsonField(
                                            FFAppState().selectedItem,
                                            r'''$.snippet.publishedAt''',
                                          )?.toString(),
                                          '0',
                                        )),
                                        '0',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Builder(
                      builder: (context) {
                        final items =
                            FFAppState().test.toList().take(100).toList();

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: items.length,
                          itemBuilder: (context, itemsIndex) {
                            final itemsItem = items[itemsIndex];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  FFAppState().selectedVideoId = getJsonField(
                                    itemsItem,
                                    r'''$.id.videoId''',
                                  ).toString();
                                  safeSetState(() {});
                                  FFAppState().selectedItem = itemsItem;
                                  safeSetState(() {});
                                  FFAppState().HTMLForWebView =
                                      '<html> <head>   <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">   <style>     .video-container {       position: relative;       width: 100%;       padding-top: 65%;       overflow: hidden;     }     .video-container iframe {       position: absolute;       top: 0; left: 0;       width: 100%; height: 100%;       border: 0;     }   </style> </head> <body style=\"margin:0;padding:0;overflow:hidden;\">   <div class=\"video-container\">     <iframe       src=\"https://www.youtube.com/embed/${FFAppState().selectedVideoId}?autoplay=0\"       allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\"       allowfullscreen>     </iframe>   </div> </body> </html>';
                                  safeSetState(() {});
                                  await _model.columnController?.animateTo(
                                    0,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.ease,
                                  );
                                },
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  child: Stack(
                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                    children: [
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0.0, 0.0),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: const AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  child: Image.network(
                                                    getJsonField(
                                                      itemsItem,
                                                      r'''$.snippet.thumbnails.default.url''',
                                                    ).toString(),
                                                    height: 100.0,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                      'assets/images/error_image.png',
                                                      height: 100.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Align(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        8.0),
                                                            child: Text(
                                                              getJsonField(
                                                                itemsItem,
                                                                r'''$.snippet.title''',
                                                              ).toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
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
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              getJsonField(
                                                                itemsItem,
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
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  functions
                                                                      .formatIsoToSlashDate(
                                                                          getJsonField(
                                                                    itemsItem,
                                                                    r'''$.snippet.publishedAt''',
                                                                  ).toString()),
                                                                  '0',
                                                                ),
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
                                                                          12.0,
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
                          controller: _model.listViewController,
                        );
                      },
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
