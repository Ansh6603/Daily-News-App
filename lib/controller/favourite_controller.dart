import 'package:get/get.dart';
import 'package:news_app_with_firebase/model/show_category_model.dart';

class FavoriteController extends GetxController {
  var favorites = <FavoriteModel>[].obs;

  void toggleFavorite(ShowCategoryModel category) {
    if (isFavorite(category)) {
      favorites.removeWhere((fav) => fav.category == category);
    } else {
      favorites.add(FavoriteModel(category: category));
    }
    update();
  }

  bool isFavorite(ShowCategoryModel category) {
    return favorites.any((fav) => fav.category == category);
  }
}

class FavoriteModel {
  final ShowCategoryModel category;

  FavoriteModel({required this.category});
}
