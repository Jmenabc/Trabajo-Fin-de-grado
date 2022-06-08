import 'dart:convert';

import 'dart:io';

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
    this.video,
  });

  String? description;
  String? artist;
  String? email;
  String? phoneNumber;
  String? name;
  String? video;

  factory ShortModel.fromJson(Map<String, dynamic> json) => ShortModel(
      description: json["description"],
      artist: json["artist"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      name: json["name"],
      video: json["video"]);

  Map<String, dynamic> toJson() => {
        "description": description,
        "artist": artist,
        "email": email,
        "phoneNumber": phoneNumber,
        "name": name,
        "video": video
      };

  @override
  String toString() {
    return 'ShortModel{description: $description, artist: $artist, email: $email, phoneNumber: $phoneNumber, name: $name, video: $video }';
  }
}
