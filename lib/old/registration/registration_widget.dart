import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'registration_model.dart';
export 'registration_model.dart';

class RegistrationWidget extends StatefulWidget {
  const RegistrationWidget({super.key});

  @override
  State<RegistrationWidget> createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  late RegistrationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RegistrationModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.channelsData = await actions.fetchChannelsListFromHiveAsJson();
      FFAppState().channelsList = _model.channelsData!.toList().cast<dynamic>();
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 200.0,
                        child: TextFormField(
                          controller: _model.textController,
                          focusNode: _model.textFieldFocusNode,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Enter YouTube Link',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0x00000000),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding: const EdgeInsets.all(8.0),
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                          keyboardType: TextInputType.url,
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        _model.parseResult =
                            actions.parseYouTubeUrlAction(
                          _model.textController.text,
                        );
                        _model.videoIdValue =
                            actions.extractValueFromJsonString(
                          _model.parseResult!,
                          'videoId',
                        );
                        _model.channelIdValue =
                            actions.extractValueFromJsonString(
                          _model.parseResult!,
                          'channelId',
                        );
                        _model.customNameValue =
                            actions.extractValueFromJsonString(
                          _model.parseResult!,
                          'customName',
                        );
                        if (_model.videoIdValue != null &&
                            _model.videoIdValue != '') {
                          _model.videoRes = await VideosListAPICallCall.call(
                            id: _model.videoIdValue,
                          );

                          if ((_model.videoRes?.succeeded ?? true)) {
                            _model.apiResultfir =
                                await ChannelsListAPICallCall.call(
                              channelId: getJsonField(
                                (_model.videoRes?.jsonBody ?? ''),
                                r'''$.items[0].snippet.channelId''',
                              ).toString(),
                            );

                            if ((_model.apiResultfir?.succeeded ?? true)) {
                              await actions.saveYoutubeChannelToHive(
                                getJsonField(
                                  (_model.videoRes?.jsonBody ?? ''),
                                  r'''$.items[0].snippet.channelId''',
                                ).toString(),
                                getJsonField(
                                  (_model.apiResultfir?.jsonBody ?? ''),
                                  r'''$.items[0].snippet.title''',
                                ).toString(),
                                getJsonField(
                                  (_model.apiResultfir?.jsonBody ?? ''),
                                  r'''$.items[0].snippet.thumbnails.default.url''',
                                ).toString(),
                              );
                              _model.fechChannelsListVideo = await actions
                                  .fetchChannelsListFromHiveAsJson();
                              FFAppState().channelsList = _model
                                  .fechChannelsListVideo!
                                  .toList()
                                  .cast<dynamic>();
                              safeSetState(() {});
                              await actions.clearVideoListJson();
                            }
                          }
                        } else {
                          if (_model.channelIdValue != null &&
                              _model.channelIdValue != '') {
                            _model.channelRes =
                                await ChannelsListAPICallCall.call(
                              channelId: _model.channelIdValue,
                            );

                            if ((_model.apiResultfir?.succeeded ?? true)) {
                              await actions.saveYoutubeChannelToHive(
                                FFAppState().ChannelId,
                                getJsonField(
                                  (_model.channelRes?.jsonBody ?? ''),
                                  r'''$.items[0].snippet.title''',
                                ).toString(),
                                getJsonField(
                                  (_model.channelRes?.jsonBody ?? ''),
                                  r'''$.items[0].snippet.thumbnails.default.url''',
                                ).toString(),
                              );
                              _model.channelsDataTap = await actions
                                  .fetchChannelsListFromHiveAsJson();
                              FFAppState().channelsList = _model
                                  .channelsDataTap!
                                  .toList()
                                  .cast<dynamic>();
                              safeSetState(() {});
                              await actions.clearVideoListJson();
                            }
                          }
                        }

                        safeSetState(() {});
                      },
                      text: 'Button',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ],
                ),
              ),
              Builder(
                builder: (context) {
                  final channlLIst =
                      FFAppState().channelsList.toList().take(5).toList();

                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: channlLIst.length,
                    itemBuilder: (context, channlLIstIndex) {
                      final channlLIstItem = channlLIst[channlLIstIndex];
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              getJsonField(
                                channlLIstItem,
                                r'''$.iconUrl''',
                              ).toString(),
                              width: 60.0,
                              height: 60.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            getJsonField(
                              channlLIstItem,
                              r'''$.channelName''',
                            ).toString(),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context).primary,
                            icon: Icon(
                              Icons.delete,
                              color: FlutterFlowTheme.of(context).info,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              await actions.deleteChannelFromHive(
                                channlLIstIndex,
                              );
                              FFAppState().removeAtIndexFromChannelsList(
                                  channlLIstIndex);
                              safeSetState(() {});
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
