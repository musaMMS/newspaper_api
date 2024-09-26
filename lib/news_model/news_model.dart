import 'package:flutter/foundation.dart';
import 'package:newspaper_api/model/catagory_channel.dart';
import 'package:newspaper_api/model/news_channel.dart';
import 'package:newspaper_api/repository/news_repository.dart';

class NewsViewModel{
  final _rep = NewsRepository();
  Future <NewsChannelHeadlinesModel> fetchNewChannelHeadlinesApi( String channelName)async{
    final response = await _rep.fetchNewChannelHeadlinesApi(channelName);
    return response;

  }
  Future <CategoryNewsModel> fetchCategoriesNewsApi( String category)async{
    final response = await _rep.fetchCategoryNewsApi(category);
    return response;

  }

}