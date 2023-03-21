import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/CategoryModel.dart';
import 'package:news_app/views/article.dart';
import '../models/ArticleModel.dart';
import 'dart:ui' as dartUi;

import 'category.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<CategoryModel> categoryModels;
  late List<ArticleModel> articles;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryModels = getCategories();
    getNews();
  }

  getNews() async {
    News news = News();
    await news.getNews();
    articles = news.articles;
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
                child: Column(
                  children: [
                    // categories

                    Categories(
                      categoryModels: categoryModels,
                    ),

                    // articles

                    Articles(
                      articles: articles,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class Articles extends StatefulWidget {
  List<ArticleModel> articles;

  Articles({required this.articles});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        bottom: 16,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.articles.length,
        physics: ClampingScrollPhysics(),
        itemBuilder: ((context, index) {
          return BlogCard(
            imageUrl: widget.articles[index].imageUrl,
            title: widget.articles[index].title,
            description: widget.articles[index].description,
            blogUrl: widget.articles[index].url,
          );
        }),
      ),
    );
  }
}

class Categories extends StatefulWidget {
  late List<CategoryModel> categoryModels;

  Categories({required this.categoryModels});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 70,
      child: ListView.builder(
          itemCount: widget.categoryModels.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return CategoryCard(
              imageUrl: widget.categoryModels[index].url,
              name: widget.categoryModels[index].name,
            );
          }),
    );
  }
}

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  dartUi.Size get preferredSize => dartUi.Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black12,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "NEWS",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Quartzo',
              fontSize: 30,
            ),
          ),
          Text(
            "APP",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              fontFamily: 'Quartzo',
              fontSize: 30,
            ),
          ),
        ],
      ),
      elevation: 0,
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageUrl, name;

  CategoryCard({required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryView(
              category: name.toLowerCase(),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 16,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                placeholder: (context, url) {
                  return Image.asset(
                    "lib/images/placeholder.png",
                  );
                },
                errorWidget: (context, url, error) {
                  return Image.asset(
                    "lib/images/placeholder.png",
                  );
                },
                imageUrl: imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black38,
              ),
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Oswald',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  final String imageUrl, title, description, blogUrl;
  BlogCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.blogUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(url: blogUrl)));
      },
      child: Container(
        // color: Colors.black12,
        margin: EdgeInsets.only(
          bottom: 16,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: Colors.white70,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) {
                    return Image.asset(
                      "lib/images/placeholder.png",
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      fit: BoxFit.fill,
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      "lib/images/placeholder.png",
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      fit: BoxFit.fill,
                    );
                  },
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              description,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
