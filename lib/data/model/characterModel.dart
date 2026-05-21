class Character {
  final int charid;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String originName;
  final String locationName;
  final int episodeCount;

  Character({
    required this.charid,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.originName,
    required this.locationName,
    required this.episodeCount,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    int parseId(dynamic value) {
      if (value is int) return value;
      if (value is String) {
        return int.tryParse(value) ??
            (throw ArgumentError.value(value, 'id', 'Invalid integer value'));
      }
      throw ArgumentError.value(value, 'id', 'Invalid type for id');
    }

    String parseString(String key) {
      final dynamic value = json[key];
      if (value == null) {
        throw ArgumentError.value(json, key, 'Missing required field "$key"');
      }
      return value.toString();
    }

    return Character(
      charid: parseId(json['id']),
      name: parseString('name'),
      status: parseString('status'),
      species: parseString('species'),
      type: (json['type']?.toString() ?? '').isEmpty ? '-' : json['type'].toString(),
      gender: parseString('gender'),
      image: parseString('image'),
      originName: json['origin'] is Map ? (json['origin']['name']?.toString() ?? 'Unknown') : 'Unknown',
      locationName: json['location'] is Map ? (json['location']['name']?.toString() ?? 'Unknown') : 'Unknown',
      episodeCount: json['episode'] is List ? json['episode'].length : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': charid,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'image': image,
      'originName': originName,
      'locationName': locationName,
      'episodeCount': episodeCount,
    };
  }
}
