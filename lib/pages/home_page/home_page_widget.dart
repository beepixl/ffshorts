import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryText,
          automaticallyImplyLeading: false,
          title: Text(
            'Shorts',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: FutureBuilder<ApiCallResponse>(
                  future: UnslpashCall.call(
                    pageNo: 1,
                    query: 'nature',
                    clientID: 'S1M_WBqP6Gqb3e-CZbIysYSEdpC0kQCKIV_2hhXgquA',
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      );
                    }
                    final pageViewUnslpashResponse = snapshot.data!;

                    return Builder(
                      builder: (context) {
                        final images = UnslpashCall.results(
                              pageViewUnslpashResponse.jsonBody,
                            )?.toList() ??
                            [];

                        return SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: PageView.builder(
                            controller: _model.pageViewController ??=
                                PageController(
                                    initialPage:
                                        max(0, min(0, images.length - 1))),
                            scrollDirection: Axis.vertical,
                            itemCount: images.length,
                            itemBuilder: (context, imagesIndex) {
                              final imagesItem = images[imagesIndex];
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      getJsonField(
                                        imagesItem,
                                        r'''$.urls.regular''',
                                      ).toString(),
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(1.0, 1.0),
                                    child: Container(
                                      height: 350.0,
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: 80.0,
                                            height: 80.0,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: CachedNetworkImage(
                                              fadeInDuration:
                                                  const Duration(milliseconds: 500),
                                              fadeOutDuration:
                                                  const Duration(milliseconds: 500),
                                              imageUrl: getJsonField(
                                                imagesItem,
                                                r'''$.user.profile_image.small''',
                                              ).toString(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Icon(
                                            Icons.thumb_up,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            size: 36.0,
                                          ),
                                          Icon(
                                            Icons.thumb_down,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            size: 36.0,
                                          ),
                                          Icon(
                                            Icons.favorite,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            size: 36.0,
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.volumeMute,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            size: 36.0,
                                          ),
                                        ].divide(const SizedBox(height: 10.0)),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
