import 'package:news_api/models/news_model.dart';

class NewsState {
  const NewsState();
}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<NewsModel> newsList;
  const NewsLoadedState({required this.newsList});
}

class NewsErrorState extends NewsState {
  final String errorMsg;
  const NewsErrorState({required this.errorMsg});
}
