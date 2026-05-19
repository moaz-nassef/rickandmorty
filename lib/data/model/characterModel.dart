class Character {
  final int charid;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;

  Character({
    required this.charid,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
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
      gender: parseString('gender'),
      image: parseString('image'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': charid,
      'name': name,
      'status': status,
      'species': species,
      'gender': gender,
      'image': image,
    };
  }
}
