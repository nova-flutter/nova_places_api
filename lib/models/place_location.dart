class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.radius,
  });

  final double latitude;
  final double longitude;
  final int? radius;

  @override
  String toString() {
    return 'PlaceLocation{ latitude: $latitude, longitude: $longitude, radius: $radius,}';
  }
}
