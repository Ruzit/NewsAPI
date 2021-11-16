import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_api/models/news_model.dart';

class NewsRepository {
  //method to fetch the news from api
  Future<List<NewsModel>> fetchNews() async {
    //empty list to store the list of news
    List<NewsModel> news = [];
    //news api url with api key
    String newsURL =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=2478486060ed4530bcd75ae71b4b18fb";

    var response = await http.get(Uri.parse(newsURL));
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          //converting the json data to NewsModel
          NewsModel newsModel = NewsModel(
            author: element['author'],
            title: element['title'],
            description: element['description'],
            imageURl: element['urlToImage'],
            content: element['content'],
          );
          //adding the above data in list
          news.add(newsModel);
        }
      });
      return news;
    } else {
      return news;
    }
  }
}
