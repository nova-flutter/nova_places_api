enum PlacesStatus {
  /// indicating the API request was successful.
  ok('OK'),

  /// indicating that the search was successful but returned no results. This may occur if the search was passed a bounds in a remote location.
  zeroResult('ZERO_RESULTS'),

  ///  indicating the API request was malformed, generally due to the missing input parameter.
  invalidRequest('INVALID_REQUEST'),

  /// indicating any of the following:
  /// You have exceeded the QPS limits.
  /// Billing has not been enabled on your account.
  /// The monthly $200 credit, or a self-imposed usage cap, has been exceeded.
  /// The provided method of payment is no longer valid (for example, a credit card has expired).
  overQueryLimit('OVER_QUERY_LIMIT'),

  /// REQUEST_DENIED indicating that your request was denied, generally because:
  /// The request is missing an API key.
  /// The key parameter is invalid.
  requestDenied('REQUEST_DENIED'),

  /// indicating an unknown error.
  unknownError('UNKNOWN_ERROR');

  const PlacesStatus(this.value);

  factory PlacesStatus.fromValue(String value) {
    if (value == 'OK') return ok;
    if (value == 'ZERO_RESULTS') return zeroResult;
    if (value == 'INVALID_REQUEST') return invalidRequest;
    if (value == 'OVER_QUERY_LIMIT') return overQueryLimit;
    if (value == 'REQUEST_DENIED') return requestDenied;
    if (value == 'UNKNOWN_ERROR') return unknownError;
    return unknownError;
  }

  final String value;
}
