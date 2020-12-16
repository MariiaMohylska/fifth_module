import 'package:dio/dio.dart';
import 'dart:convert';

import 'data.dart';

final dio = Dio();

 Future<List<dynamic>> getResponse()  async {
   final response = await dio.get("https://jsonplaceholder.typicode.com/photos");
   return response.data;
}

Future<Iterable<Data>> getData() async{
   final listResponse = await getResponse();
   final listData = listResponse.map((v){
     return Data.fromJson(v);
   });
   return listData;
}