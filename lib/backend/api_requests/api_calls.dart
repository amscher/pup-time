import 'api_manager.dart';

Future<dynamic> getArtPieceCall({
  String objectID = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'Get Art Piece',
    apiUrl:
        'https://collectionapi.metmuseum.org/public/collection/v1/objects/$objectID',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> departmentHighlightsCall({
  int departmentId,
  bool isHighlight = true,
  String q = '*',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'Department Highlights',
    apiUrl: 'https://collectionapi.metmuseum.org/public/collection/v1/search',
    callType: ApiCallType.GET,
    headers: {},
    params: {
      'departmentId': departmentId,
      'isHighlight': isHighlight,
      'q': q,
    },
    returnResponse: true,
  );
}

Future<dynamic> getLearningItemsCall() {
  return ApiManager.instance.makeApiCall(
    callName: 'Get Learning Items',
    apiUrl: 'https://api.airtable.com/v0/appfS6E3cWCN4oka6/Items',
    callType: ApiCallType.GET,
    headers: {
      'Authorization': 'Bearer keybqurfA31BclNFw',
    },
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> getLearningItemCall({
  String itemID = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'Get Learning Item',
    apiUrl: 'https://api.airtable.com/v0/appfS6E3cWCN4oka6/Items/$itemID',
    callType: ApiCallType.GET,
    headers: {
      'Authorization': 'Bearer keybqurfA31BclNFw',
    },
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> getItemsForStageCall({
  String view = 'stageName',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'Get Items For Stage',
    apiUrl: 'https://api.airtable.com/v0/appfS6E3cWCN4oka6/Items',
    callType: ApiCallType.GET,
    headers: {
      'Authorization': 'Bearer keybqurfA31BclNFw',
    },
    params: {
      'view': view,
    },
    returnResponse: true,
  );
}

Future<dynamic> getLevelCall({
  String levelID = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'Get Level',
    apiUrl: 'https://api.airtable.com/v0/appfS6E3cWCN4oka6/Levels/$levelID',
    callType: ApiCallType.GET,
    headers: {
      'Authorization': 'Bearer keybqurfA31BclNFw',
    },
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> getTrainingStagesCall({
  String view = 'Sorted',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'Get Training Stages',
    apiUrl: 'https://api.airtable.com/v0/appfS6E3cWCN4oka6/Stages',
    callType: ApiCallType.GET,
    headers: {
      'Authorization': 'Bearer keybqurfA31BclNFw',
    },
    params: {
      'view': view,
    },
    returnResponse: true,
  );
}
