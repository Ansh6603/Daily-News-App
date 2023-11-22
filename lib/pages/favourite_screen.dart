import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app_with_firebase/controller/favourite_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: Obx(
        () {
          final favorites = favoriteController.favorites;
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              final category = favorite.category;

              return InkWell(
                onTap: () {
                  launch(category.url!);
                },
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      category.urlToImage!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(category.title!),
                  trailing: IconButton(
                    icon: Icon(
                      favoriteController.isFavorite(category)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favoriteController.isFavorite(category)
                          ? Colors.red
                          : null,
                    ),
                    onPressed: () {
                      favoriteController.toggleFavorite(category);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
