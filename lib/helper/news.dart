import 'dart:convert';

import 'package:dailyindiannews/models/article_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews () async{

  String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=7280b24426fe47b5a2fd4e7c7127b1a1";

  var response = await http.get(Uri.parse(url));

  var jsonData = jsonDecode(response.body);

  if(jsonData['status'] == "ok"){
    jsonData["articles"].forEach((element){

      if(element["urlToImage"] != null && element['description'] != null){

        ArticleModel articleModel = ArticleModel(

          title:  element['title'],
          author:  element['author'],
          description:element['description'],
          url: element['url'],
          urlToImage: element['urlToImage'],
            content: element['content']
        );
        news.add(articleModel);
      }


    });
  }
}
}