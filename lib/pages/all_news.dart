import 'package:flutter/material.dart';
import 'package:news_app_with_firebase/info/news.dart';
import 'package:news_app_with_firebase/info/slider_data.dart';
import 'package:news_app_with_firebase/model/article_model.dart';
import 'package:news_app_with_firebase/model/slider_model.dart';
import 'package:news_app_with_firebase/pages/grid_view.dart';
import 'package:news_app_with_firebase/pages/list_view.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews({super.key, required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<sliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool isGridView = false;
  @override
  void initState() {
    getSlider();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;
    setState(() {});
  }

  getSlider() async {
    Sliders slider = Sliders();
    await slider.getSlider();
    sliders = slider.sliders;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.news} News",
          style:
              const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: toggleView,
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: isGridView
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: widget.news == "Breaking"
                    ? sliders.length
                    : articles.length,
                itemBuilder: (context, index) {
                  return GridNewsSection(
                    Image: widget.news == "Breaking"
                        ? sliders[index].urlToImage!
                        : articles[index].urlToImage!,
                    title: widget.news == "Breaking"
                        ? sliders[index].title!
                        : articles[index].title!,
                    url: widget.news == "Breaking"
                        ? sliders[index].url!
                        : articles[index].url!,
                  );
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.news == "Breaking"
                    ? sliders.length
                    : articles.length,
                itemBuilder: (context, index) {
                  return ListNewsSection(
                    Image: widget.news == "Breaking"
                        ? sliders[index].urlToImage!
                        : articles[index].urlToImage!,
                    desc: widget.news == "Breaking"
                        ? sliders[index].description!
                        : articles[index].description!,
                    title: widget.news == "Breaking"
                        ? sliders[index].title!
                        : articles[index].title!,
                    url: widget.news == "Breaking"
                        ? sliders[index].url!
                        : articles[index].url!,
                  );
                },
              ),
      ),
    );
  }

  void toggleView() {
    setState(() {
      isGridView = !isGridView;
    });
  }
}
