import 'dart:convert';

ShortModel shortModelFromJson(String str) =>
    ShortModel.fromJson(json.decode(str));

String shortModelToJson(ShortModel data) => json.encode(data.toJson());

class ShortModel {
  ShortModel({
    this.description,
    this.artist,
    this.email,
    this.phoneNumber,
    this.name,
  });

  String? description;
  String? artist;
  String? email;
  String? phoneNumber;
  String? name;

  factory ShortModel.fromJson(Map<String, dynamic> json) => ShortModel(
      description: json["description"],
      artist: json["artist"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      name: json["name"]);

  Map<String, dynamic> toJson() => {
        "description": description,
        "artist": artist,
        "email": email,
        "phoneNumber": phoneNumber,
        "name": name
      };

  @override
  String toString() {
    return 'ShortModel{description: $description, artist: $artist, email: $email, phoneNumber: $phoneNumber, name: $name}';
  }
}
