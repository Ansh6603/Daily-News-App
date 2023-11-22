import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_with_firebase/controller/favourite_controller.dart';
import 'package:news_app_with_firebase/info/show_category_news.dart';
import 'package:news_app_with_firebase/model/show_category_model.dart';
import 'package:news_app_with_firebase/pages/article_view.dart';

class CategoryNews extends StatefulWidget {
  String name;
  CategoryNews({required this.name, super.key});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
  bool _loading = true;
  final FavoriteController favoriteController = Get.find();

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
    categories = showCategoryNews.categories;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style:
              const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return category != null
                ? ShowCategory(
                    image: category.urlToImage ?? "",
                    desc: category.description ?? "",
                    title: category.title ?? "",
                    url: category.url ?? "",
                    isFavorite: favoriteController.isFavorite(category),
                    onFavoritePressed: () {
                      favoriteController.toggleFavorite(category);
                    },
                  )
                : Container();
          },
        ),
      ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  final String image, desc, title, url;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  const ShowCategory({
    required this.image,
    required this.desc,
    required this.title,
    required this.url,
    required this.isFavorite,
    required this.onFavoritePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(blogUrl: url),
          ),
        );
      },
      child: GetBuilder<FavoriteController>(
        builder: (controller) {
          return Container(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(desc, maxLines: 3),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: onFavoritePressed,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
