import 'package:nova_google_services_core/nova_google_services_core.dart';

import '../models/places_autocomplete_response.dart';
import '../models/places_details_response.dart';
import '../utils/session_token.dart';

class PlacesApi extends GoogleWebService {
  PlacesApi({
    bool debug = false,
    String? apiKey,
  }) : super(
          baseUri: Uri.https('maps.googleapis.com'),
          serviceName: 'NovaPlacesApi',
          debug: debug,
          apiKey: apiKey,
        );

  /// The Place Autocomplete service is a web service that returns place predictions in response to an HTTP request.
  /// The request specifies a textual search string and optional geographic bounds.
  /// The service can be used to provide autocomplete functionality for text-based geographic searches,
  /// by returning places such as businesses, addresses and points of interest as a user types.
  Future<PlacesAutocompleteResponse> placeAutocomplete({
    required String input,
    String? language,
    List<String>? components,
    LatLngLiteral? location,
    double? radius,
    int? offset,
    String? region,
    String? sessionToken,
    bool? strictBounds,
    List<String>? types,
  }) async {
    final qp = <String, dynamic>{
      'input': input,
      if (language != null) 'language': language,
      if (components != null) 'components': components,
      if (location != null) 'location': '${location.lat},${location.lng}',
      if (radius != null) 'radius': radius,
      if (offset != null) 'offset': offset,
      if (region != null) 'region': region,
      'sessiontoken': sessionToken ?? generateSessionToken(),
      if (strictBounds != null) 'strictBounds': strictBounds,
      if (types != null) 'types': types,
    };

    try {
      final data = await doGet(
        path: '/maps/api/place/autocomplete/json',
        params: qp,
      );

      return PlacesAutocompleteResponse.fromMap(data);
    } catch (error) {
      final gr = PlacesAutocompleteResponse.fromError(error.toString());
      return gr;
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
    LatLngLiteral? location,
    double? radius,
    int? offset,
  }) async {
    final qp = <String, dynamic>{
      'input': input,
      if (language != null) 'language': language,
      if (location != null) 'location': '${location.lat},${location.lng}',
      if (offset != null) 'offset': offset,
      if (radius != null) 'radius': radius,
    };

    try {
      final data = await doGet(
        path: '/maps/api/place/queryautocomplete/json',
        params: qp,
      );

      return PlacesAutocompleteResponse.fromMap(data);
    } catch (error) {
      final gr = PlacesAutocompleteResponse.fromError(error.toString());
      return gr;
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
      'place_id': placeId,
      if (language != null) 'language': language,
      if (region != null) 'region': region,
      'sessiontoken': sessionToken ?? generateSessionToken(),
    };

    try {
      final data = await doGet(
        path: '/maps/api/place/details/json',
        params: qp,
      );

      return PlacesDetailsResponse.fromMap(data);
    } catch (error, sta) {
      print(error);
      print(sta);
      final gr = PlacesDetailsResponse.fromError(error.toString());
      return gr;
    }
  }
}
