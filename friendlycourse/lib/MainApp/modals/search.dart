// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, duplicate_ignore, avoid_print, unnecessary_null_comparison

// import 'dart:html';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:friendlycourse/MainApp/modals/videos_api.dart';
import 'package:friendlycourse/MainApp/screens/home_page.dart';

class DataSearch extends SearchDelegate<String> {
  final videos = [
    '2020 Machine Learning Roadmap (still valid for 2021)',
    'Lesson 1 - Deep Learning for Coders (2020)',
    '	How to Debug Python with VSCode',
    'Stock market for beginners - My Investment Strategies revealed',
    'App development',
    'How to get Machine learning intership',
    'Git & Github Tutorial For Beginners In Hindi',
    'Can you solve this McNuggets Puzzel',
    'How to fix Footage with color correction',
    'How to invest in stocks'
  ];
  final recentVideos = [
    'Lesson 1 - Deep Learning for Coders (2020)',
    '	How to Debug Python with VSCode',
    'Machine learning'
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: const Icon(
        Icons.clear,
      ),
      onPressed: () {
        if (query.isEmpty) {
        } else {
          query = '';
          showSuggestions(context);
        }
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        // close(context, ); 
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) => FutureBuilder<List>(
        future: VideosApi.getVideos(query),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListVideo(
                  list: snapshot.data ?? [],
                  query: query,
                )
              : Center(child: CircularProgressIndicator());
        },
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentVideos
        : videos.where((video) {
            final videoLower = video.toLowerCase();
            final queryLower = query.toLowerCase();
            return videoLower.contains(queryLower);
          }).toList();
    return buildSuggestionSuccess(suggestions);
  }

  Widget buildSuggestionSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            onTap: () {
              query = suggestion;

              showResults(context);
            },
            leading: Icon(Icons.video_label),
            title: Text(suggestion),
          );
        },
      );
}

class ListVideo extends StatelessWidget {
  final List list;
  final String query;
  const ListVideo({Key? key, required this.list, required this.query})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          String name = list[i]['snippet']['title'];
          String title = name.toLowerCase();
          String search = query.toLowerCase();
          if (title.contains(search)) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Column(children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => VideoPlay(
                          url:
                              "https://youtube.com/embed/${list[i]['contentDetails']['videoId']}"))),
                  child: Container(
                    height: 210.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            list[i]['snippet']['thumbnails']['high']['url']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Text(
                  list[i]['snippet']['title'],
                  style: TextStyle(fontSize: 18.0),
                )
              ]),
            );
          } else {
            return SizedBox.shrink();
          }
        });
  }
}
