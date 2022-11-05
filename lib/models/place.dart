class Place {
  const Place({
    this.placeId,
    this.addressComponents,
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.geometry,
    this.name,
  });

  final String? placeId;
  final List<AddressComponent>? addressComponents;
  final String? formattedAddress;
  final String? formattedPhoneNumber;
  final Geometry? geometry;
  final String? name;

  @override
  String toString() {
    return 'Place{ placeId: $placeId, addressComponents: $addressComponents, formattedAddress: $formattedAddress, formattedPhoneNumber: $formattedPhoneNumber, geometry: $geometry, name: $name,}';
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      placeId: map['place_id'] as String,
      addressComponents: parseAddressComponentArray(map['address_components']),
      formattedAddress: map['formatted_address'],
      formattedPhoneNumber: map['formatted_phone_number'],
      geometry:
          map['geometry'] == null ? null : Geometry.fromMap(map['geometry']),
      name: map['name'],
    );
  }
}

///
///
///
class AddressComponent {
  const AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  final String longName;
  final String shortName;
  final List<String> types;

  @override
  String toString() {
    return 'AddressComponent{ longName: $longName, shortName: $shortName, types: $types,}';
  }

  factory AddressComponent.fromMap(Map<String, dynamic> map) {
    return AddressComponent(
      longName: map['long_name'],
      shortName: map['short_name'],
      types: map['types'].cast<String>(),
    );
  }
}

///
///
///
List<AddressComponent>? parseAddressComponentArray(List? items) {
  if (items == null) return null;
  final components = <AddressComponent>[];
  for (final item in items) {
    final comp = AddressComponent.fromMap(item);
    components.add(comp);
  }
  return components;
}

///
///
///
class PlaceEditorialSummary {
  const PlaceEditorialSummary({
    this.language,
    this.overview,
  });

  final String? language;
  final String? overview;

  @override
  String toString() {
    return 'PlaceEditorialSummary{ language: $language, overview: $overview,}';
  }

  factory PlaceEditorialSummary.fromMap(Map<String, dynamic> map) {
    return PlaceEditorialSummary(
      language: map['language'],
      overview: map['overview'],
    );
  }
}

///
///
///
class Geometry {
  const Geometry({
    required this.location,
    required this.viewport,
  });

  final LatLngLiteral location;
  final Bounds viewport;

  @override
  String toString() {
    return 'Geometry{ location: $location, viewport: $viewport,}';
  }

  factory Geometry.fromMap(Map<String, dynamic> map) {
    return Geometry(
      location: LatLngLiteral.fromMap(map['location']),
      viewport: Bounds.fromMap(map['viewport']),
    );
  }
}

///
///
///
class LatLngLiteral {
  const LatLngLiteral({
    required this.lat,
    required this.lng,
  });

  /// Latitude in decimal degrees
  final double lat;

  /// Longitude in decimal degrees
  final double lng;

  @override
  String toString() {
    return 'LatLngLiteral{ lat: $lat, lng: $lng,}';
  }

  factory LatLngLiteral.fromMap(Map<String, dynamic> map) {
    return LatLngLiteral(
      lat: map['lat'].toDouble(),
      lng: map['lng'].toDouble(),
    );
  }
}

///
///
///
class Bounds {
  const Bounds({
    required this.northeast,
    required this.southwest,
  });

  final LatLngLiteral northeast;
  final LatLngLiteral southwest;

  @override
  String toString() {
    return 'Bounds{ northeast: $northeast, southwest: $southwest,}';
  }

  factory Bounds.fromMap(Map<String, dynamic> map) {
    return Bounds(
      northeast: LatLngLiteral.fromMap(map['northeast']),
      southwest: LatLngLiteral.fromMap(map['southwest']),
    );
  }
}
