import 'dart:convert';
import 'package:http/http.dart' as http;

class Video {
  final String title;
  final String thumbnails;

  const Video({
    required this.title,
    required this.thumbnails,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        title: json['snippet']['title'],
        thumbnails: json['snippet']['thumnails']['high']['url'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'thumbnails': thumbnails,
      };
}

class VideosApi {
  // ignore: prefer_typing_uninitialized_variables

  static Future<List> getVideos(String query) async {
    final response =
        await http.get(Uri.parse("https://yotube-flutter-app.herokuapp.com/"));

    final List videos = json.decode(response.body);
    return videos;
  }
}
