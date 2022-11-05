import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import '../models/place_location.dart';
import '../models/places_autocomplete_response.dart';
import '../models/places_details_response.dart';
import '../utils/session_token.dart';

class PlacesApi {
  PlacesApi(this._apiKey)
      : _log = Logger('NovaPlacesApi'),
        _language = 'en';

  final Logger _log;
  String _apiKey;
  String _language;

  String get apiKey => _apiKey;

  String get language => _language;

  void setApiKey(String key) => _apiKey = key;

  void setLanguage(String language) => _language = language;

  /// The Place Autocomplete service is a web service that returns place predictions in response to an HTTP request.
  /// The request specifies a textual search string and optional geographic bounds.
  /// The service can be used to provide autocomplete functionality for text-based geographic searches,
  /// by returning places such as businesses, addresses and points of interest as a user types.
  Future<PlacesAutocompleteResponse> placeAutocomplete({
    required String input,
    String? language,
    String? components,
    PlaceLocation? location,
    int? offset,
    String? region,
    String? sessionToken,
    bool? strictBounds,
    String? types,
  }) async {
    final qp = <String, dynamic>{
      'key': _apiKey,
      'input': input,
      'language': language ?? this.language,
      if (components != null) 'components': components,
      if (location != null)
        'location': '${location.latitude},${location.longitude}',
      if (location != null && location.radius != null)
        'radius': '${location.radius}',
      if (offset != null) 'offset': '$offset',
      if (region != null) 'region': region,
      'sessiontoken': sessionToken ?? generateSessionToken(),
      if (strictBounds != null) 'strictBounds': '$strictBounds',
      if (types != null) 'types': types,
    };

    final url = Uri.https(
      'maps.googleapis.com',
      '/maps/api/place/autocomplete/json',
      qp,
    );

    _log.info('Request: ${url.toString()}');

    try {
      var response = await http.get(url);
      final data = response.body;
      _log.info('Request: ${url.toString()}, Response: $data');
      final jsonBody = json.decode(data);
      final pr = PlacesAutocompleteResponse.fromMap(jsonBody);
      return pr;
    } catch (error) {
      _log.warning('Request: ${url.toString()}, Response: $error');
      final pr = PlacesAutocompleteResponse.fromError(error.toString());
      return pr;
    }
  }

  /// The Query Autocomplete service allows you to add on-the-fly geographic query predictions to your application.
  /// Instead of searching for a specific location, a user can type in a categorical search,
  /// such as "pizza near New York" and the service responds with a list of suggested queries matching the string.
  /// As the Query Autocomplete service can match on both full words and substrings,
  /// applications can send queries as the user types to provide on-the-fly predictions.
  Future<PlacesAutocompleteResponse> queryAutocomplete({
    required String input,
    String? language,
    PlaceLocation? location,
    int? offset,
  }) async {
    final qp = <String, dynamic>{
      'key': _apiKey,
      'input': input,
      'language': language ?? this.language,
      if (location != null)
        'location': '${location.latitude},${location.longitude}',
      if (offset != null) 'offset': '$offset',
      if (location != null && location.radius != null)
        'radius': '${location.radius}',
    };

    final url = Uri.https(
      'maps.googleapis.com',
      '/maps/api/place/queryautocomplete/json',
      qp,
    );

    _log.info('Request: ${url.toString()}');

    try {
      var response = await http.get(url);
      final data = response.body;
      _log.info('Request: ${url.toString()}, Response: $data');
      final jsonBody = json.decode(data);
      final pr = PlacesAutocompleteResponse.fromMap(jsonBody);
      return pr;
    } catch (error) {
      _log.warning('Request: ${url.toString()}, Response: $error');
      final pr = PlacesAutocompleteResponse.fromError(error.toString());
      return pr;
    }
  }

  /// Once you have a place_id from a Place Search, you can request more details about a particular establishment or point of interest by initiating a Place Details request.
  /// A Place Details request returns more comprehensive information about the indicated place such as its complete address, phone number, user rating and reviews.
  Future<PlacesDetailsResponse> getPlaceDetails({
    required String placeId,
    String? language,
    String? region,
    String? sessionToken,
  }) async {
    final qp = <String, dynamic>{
      'key': _apiKey,
      'place_id': placeId,
      'language': language ?? this.language,
      if (region != null) 'region': region,
      'sessiontoken': sessionToken ?? generateSessionToken(),
    };

    final url = Uri.https(
      'maps.googleapis.com',
      '/maps/api/place/details/json',
      qp,
    );

    _log.info('Request: ${url.toString()}');

    try {
      var response = await http.get(url);
      final data = response.body;
      _log.info('Request: ${url.toString()}, Response: $data');
      final jsonBody = json.decode(data);
      final pr = PlacesDetailsResponse.fromMap(jsonBody);
      return pr;
    } catch (error) {
      _log.warning('Request: ${url.toString()}, Response: $error');
      final pr = PlacesDetailsResponse.fromError(error.toString());
      return pr;
    }
  }
}
