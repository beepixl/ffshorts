import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class UnslpashCall {
  static Future<ApiCallResponse> call({
    int? pageNo,
    String? query = '',
    String? clientID = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'unslpash',
      apiUrl:
          'https://api.unsplash.com/search/photos?page=$pageNo&per_page=10&query=$query&client_id=$clientID',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'PageNo': pageNo,
        'query': query,
        'clientID': clientID,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? results(dynamic response) => getJsonField(
        response,
        r'''$.results''',
        true,
      ) as List?;
  static String? image(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].urls.regular''',
      ));
  static String? profileimage(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results[:].user.profile_image.small''',
      ));
  static String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].user.name''',
      ));
  static String? username(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results[:].user.username''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
