import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'network.dart';

import 'app_route.dart';

class Data{
  final  int id;
  final String title;
  final String url;
  final String thumbnail;

  Data(this.id, this.title, this.url, this.thumbnail);

  Data.fromJson(Map <String, dynamic> json):
        id = json['id'],
        title = json['title'],
        url = json['url'],
        thumbnail = json['thumbnailUrl'];

  // @override
  // String toString() {
  //   return title
  // }
}

Future<List<Widget>> listTileWithData(BuildContext context) async {
  final data = await getData();
  List<Widget> listTiles = [];
  for (Data d in data){
    listTiles.add( GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AppRoute.first, arguments: d),
      child: Card(
        child: ListTile(
          leading: Image.network(d.thumbnail),
          title: Text(d.title),
          subtitle: Text("ID = ${d.id}"),
        ),
      ),
    ));
  }
  return listTiles;
}