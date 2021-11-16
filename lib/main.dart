import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/blocs/news_bloc.dart';
import 'package:news_api/blocs/news_states.dart';
import 'package:news_api/services/news.dart';
import 'package:news_api/views/news_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(
            initialState: NewsInitialState(),
            newsRepository: NewsRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'News API',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: const ColorScheme.light().copyWith(
            primary: Colors.white,
            secondary: Colors.black38,
          ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ),
        home: const NewsPage(),
      ),
    );
  }
}
