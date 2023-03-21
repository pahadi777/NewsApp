import 'package:flutter/material.dart';
import 'package:news_app/views/home.dart';
import '../helper/news.dart';
import '../models/ArticleModel.dart';
// import 'package:news_app/helper/news.dart';

class CategoryView extends StatefulWidget {
  String category;

  CategoryView({required this.category});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  late List<ArticleModel> articles;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews categoryNews = CategoryNews();
    await categoryNews.getNews(widget.category);
    articles = categoryNews.articles;
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: loading
          ? Center(
              child: Container(
                // color: Colors.black12,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                color: Colors.black12,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Articles(
                  articles: articles,
                ),
              ),
            ),
    );
  }
}
