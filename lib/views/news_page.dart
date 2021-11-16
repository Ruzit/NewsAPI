import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/Shared/loading.dart';
import 'package:news_api/blocs/news_bloc.dart';
import 'package:news_api/blocs/news_states.dart';
import 'package:news_api/models/news_model.dart';
import 'package:news_api/views/description_page.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'NewsBloc',
            style: TextStyle(fontSize: 25),
          ),
          // centerTitle: true,
        ),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoadingState) {
              return const Loading();
            } else if (state is NewsLoadedState) {
              List<NewsModel> newsList = [];
              newsList = state.newsList;
              return NewsTile(
                newsList: newsList,
              );
            } else if (state is NewsErrorState) {
              String error = state.errorMsg;

              return Center(
                child: Text(error),
              );
            } else {
              return const Loading();
            }
          },
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final List<NewsModel> newsList;
  const NewsTile({Key? key, required this.newsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DescriptionPage(
                  news: newsList[index],
                ),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.all(15),
            elevation: 8.0,
            // width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      newsList[index].imageURl!,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Text(
                    newsList[index].title!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
