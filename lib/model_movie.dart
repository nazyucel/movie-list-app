import 'dart:convert';

MovieList movieListFromJson(String str) => MovieList.fromJson(json.decode(str));

String movieListToJson(MovieList data) => json.encode(data.toJson());

class MovieList {
  MovieList({
    this.status,
    required this.data,
    this.message,
  });

  String? status;
  List<Datum> data;
  String? message;

  factory MovieList.fromJson(Map<String, dynamic> json) => MovieList(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    required this.title,
    required this.thumbnail,
    required this.information,
    required this.tags,
  });

  String title;
  String thumbnail;
  String information;
  List<String> tags;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        thumbnail: json["thumbnail"],
        information: json["information"],
        tags: List<String>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "thumbnail": thumbnail,
        "information": information,
        "tags": List<dynamic>.from(tags.map((x) => x)),
      };
}
