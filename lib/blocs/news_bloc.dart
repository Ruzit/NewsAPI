import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/blocs/news_events.dart';
import 'package:news_api/blocs/news_states.dart';
import 'package:news_api/models/news_model.dart';
import 'package:news_api/services/news.dart';

class NewsBloc extends Bloc<NewsEvents, NewsState> {
  NewsRepository newsRepository;
  NewsBloc({required NewsState initialState, required this.newsRepository})
      : super(initialState) {
    add(StartEvent());
  }

  @override
  Stream<NewsState> mapEventToState(NewsEvents event) async* {
    if (event is StartEvent) {
      try {
        List<NewsModel> newsList = [];
        yield NewsLoadingState();
        newsList = await newsRepository.fetchNews();
        yield NewsLoadedState(newsList: newsList);
      } catch (e) {
        yield NewsErrorState(errorMsg: e.toString());
      }
    }
  }
}
