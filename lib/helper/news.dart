import 'dart:convert';

import '../models/ArticleModel.dart';
import 'package:http/http.dart' as http;

class News{

  List<ArticleModel> articles = [];

  var uri = Uri.parse("https://newsapi.org/v2/top-headlines?country=in&apiKey=f3202ec6fc374827b4612aadeff124b7");

  Future<void> getNews() async{
    var response = await http.get(uri);
    var jsondata = jsonDecode(response.body);
    if(jsondata['status'] == 'ok'){
      jsondata['articles'].forEach((element){
        if(element['url'] != null && element['urlToImage'] != null && element['description'] != null && element['title'] != null){
          articles.add(ArticleModel(element['title'], element['url'], element['urlToImage'], element['description']));
        }
      });
    }
  }
}

class CategoryNews{

  List<ArticleModel> articles = [];

  Future<void> getNews(String category) async{
    var uri = Uri.parse("https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=f3202ec6fc374827b4612aadeff124b7");
    var response = await http.get(uri);
    var jsondata = jsonDecode(response.body);
    if(jsondata['status'] == 'ok'){
      jsondata['articles'].forEach((element){
        if(element['url'] != null && element['urlToImage'] != null && element['description'] != null && element['title'] != null){
          articles.add(ArticleModel(element['title'], element['url'], element['urlToImage'], element['description']));
        }
      });
    }
  }
}