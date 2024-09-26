import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'package:newspaper_api/model/catagory_channel.dart';
import 'package:newspaper_api/model/news_channel.dart';

class NewsRepository{
  Future<NewsChannelHeadlinesModel>fetchNewChannelHeadlinesApi(String channelName)async{
    String url ='https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=578a6c8c294f49cdaad33fd66358fadb';
    final response = await http.get(Uri.parse(url));
    if(kDebugMode){
      print(response.body);
    }
    if(response.statusCode==200){
      final body =jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    throw Exception('Eroor');
  }
  Future<CategoryNewsModel>fetchCategoryNewsApi(String category)async{
    String url ='https://newsapi.org/v2/everything?q=${category}&apiKey=578a6c8c294f49cdaad33fd66358fadb';
    final response = await http.get(Uri.parse(url));
    if(kDebugMode){
      print(response.body);
    }
    if(response.statusCode==200){
      final body =jsonDecode(response.body);
      return CategoryNewsModel.fromJson(body);
    }
    throw Exception('Eroor');
  }
}