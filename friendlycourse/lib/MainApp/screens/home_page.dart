// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, unused_element, avoid_unnecessary_containers, avoid_print, unnecessary_null_comparison, unused_import

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendlycourse/MainApp/modals/search.dart';
import 'package:friendlycourse/MainApp/screens/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.url, required this.title})
      : super(key: key);
  final String title, url;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List> getData() async {
    final response = await http.get(Uri.parse(widget.url));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            )
          ],
        ),
        body: FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListVideo(
                    list: snapshot.data ?? [],
                  )
                : Center(child: CircularProgressIndicator());
          },
        ));
  }
}

class ListVideo extends StatelessWidget {
  final List list;

  const ListVideo({Key? key, required this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          
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
        });
  }
}

class VideoPlay extends StatelessWidget {
  final String url;

  const VideoPlay({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WebviewScaffold(url: url),
    );
  }
}
